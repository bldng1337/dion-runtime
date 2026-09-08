use std::rc::Rc;

use anyhow::{Context as ErrorContext, Result};
use boa_engine::Context;

use crate::utils::VirtualModuleLoader;

mod action_js;
mod auth_js;
mod convert_js;
mod networking_js;
mod parse_js;
mod permission_js;
mod setting_js;
mod specta;
mod store_js;
mod url_js;

pub fn declare(context: &mut Context, loader: &Rc<VirtualModuleLoader>) -> Result<()> {
    url_js::declare(context).context("Failed to declare url lib")?;
    parse_js::declare(context, loader).context("Failed to declare parse lib")?;
    convert_js::declare(context, loader).context("Failed to declare convert lib")?;
    networking_js::declare(context, loader).context("Failed to declare networking lib")?;
    permission_js::declare(context, loader).context("Failed to declare permission lib")?;
    auth_js::declare(context, loader).context("Failed to declare auth lib")?;
    setting_js::declare(context, loader).context("Failed to declare setting lib")?;
    action_js::declare(context, loader).context("Failed to declare action lib")?;
    store_js::declare(context, loader).context("Failed to declare store lib")?;
    Ok(())
}
