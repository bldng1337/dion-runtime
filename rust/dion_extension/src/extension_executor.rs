use boa_engine::Context as JSContext;
use tokio::{
    runtime::Builder,
    sync::{
        mpsc::{UnboundedSender, unbounded_channel},
        oneshot,
    },
    task::LocalSet,
};

use anyhow::{Context, Result};

#[async_trait::async_trait(?Send)]
pub trait JSExecutor<T> {
    async fn init(&self) -> Result<JSContext>;
    async fn handle(&self, value: T, context: &mut JSContext);
}

#[derive(Debug)]
pub struct ThreadedJSContext<T: Send + Sync + 'static> {
    sender: UnboundedSender<T>,
}

impl<T: Send + Sync + 'static> ThreadedJSContext<T> {
    pub(crate) async fn create<E: JSExecutor<T> + Send + Sync + 'static>(
        executor: E,
    ) -> Result<ThreadedJSContext<T>> {
        let (initsend, initresponse) = oneshot::channel();
        let (sender, mut recv) = unbounded_channel::<T>();
        std::thread::spawn(move || {
            let rt = match Builder::new_current_thread().enable_all().build() {
                Ok(rt) => rt,
                Err(err) => {
                    let _ = initsend.send(Err(anyhow::anyhow!("Failed to build runtime: {}", err)));
                    return;
                }
            };
            let local = LocalSet::new();
            let executor = executor;
            local.spawn_local(async move {
                let mut context: JSContext = match executor.init().await {
                    Ok(context) => {
                        let _ = initsend.send(Ok(()));
                        context
                    }
                    Err(err) => {
                        let _ = initsend.send(Err(err));
                        return;
                    }
                };
                while let Some(value) = recv.recv().await {
                    executor.handle(value, &mut context).await;
                }
            });
            rt.block_on(local);
        });
        initresponse
            .await
            .context("Message channel to extension thread failed")?
            .context("Extension failed to startup")?;
        Ok(ThreadedJSContext { sender })
    }

    pub(crate) fn send(&self, value: T) -> Result<()> {
        self.sender.send(value)?;
        Ok(())
    }
}
