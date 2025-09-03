import { expect, test } from "bun:test";
import { ExtensionManager } from "../../../js/dion_runtime";
import * as utils from "../utils";

test("test parse_html", async () => {
	const mockmanager = new utils.MockManagerClient("./html");
	const manager = await ExtensionManager.init(mockmanager.client);
	const ext = (await manager.getExtension())[0];
	expect(ext).toBeDefined();
	// We only enable here because we only use the load function so we dont need a server supplying demo data
	await ext.setEnabled(true);
});
