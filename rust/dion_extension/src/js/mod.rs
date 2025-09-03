use std::rc::Rc;

use anyhow::{Context as ErrorContext, Result};
use boa_engine::Context;

use crate::utils::VirtualModuleLoader;

mod convert_js;
mod networking_js;
mod parse_js;
mod permission_js;
mod setting_js;
mod specta;

pub fn declare(context: &mut Context, loader: &Rc<VirtualModuleLoader>) -> Result<()> {
    parse_js::declare(context, loader).context("Failed to declare parse lib")?;
    convert_js::declare(context, loader).context("Failed to declare convert lib")?;
    networking_js::declare(context, loader).context("Failed to declare networking lib")?;
    permission_js::declare(context, loader).context("Failed to declare permission lib")?;
    setting_js::declare(context, loader).context("Failed to declare setting lib")?;
    Ok(())
}
