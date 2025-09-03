/// <reference path="../../../js/dion_extension_types/index.d.ts" />
import { hasPermission, requestPermission } from "permission";
import { assert, DefaultExtension } from "../extensionutils";

export default class extends DefaultExtension {
	async load() {
		{
			const storage: Permission = {
				type: "Storage",
				path: "some",
				write: false,
			};
			const permission = await requestPermission(storage, "some permission");
			assert(permission === true, "permission was not granted");
			assert(
				(await hasPermission(storage)) === true,
				"permission is not granted even though it was granted before",
			);
		}
		{
			const deny_permission: Permission = {
				type: "Storage",
				path: "other",
				write: true,
			};
			const permission = await requestPermission(deny_permission, "deny");
			assert(permission === false, "permission was granted");
			assert(
				(await hasPermission(deny_permission)) === false,
				"permission is granted even though it was denied before",
			);
		}
	}
}
