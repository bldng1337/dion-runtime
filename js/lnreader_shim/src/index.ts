// Entry point of the `lnreader` host module. The lnreader adapter generates
// one Dion extension per installed plugin that does:
//
//   import { createExtension } from "lnreader";
//   export default createExtension({ pluginId, lang }, "<plugin code>");

import { installLenientDate } from "./date.ts";
import { installGlobals } from "./web.ts";

installGlobals();
installLenientDate();

export {
	createExtension,
	htmlToParagraphs,
	type PluginMeta,
} from "./extension.ts";
export { DEFAULT_USER_AGENT } from "./libs/fetch.ts";
