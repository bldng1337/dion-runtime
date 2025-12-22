import type { Permission } from "@dion-js/runtime-types/runtime";
import { assert, DefaultExtension } from "@dion-js/unit-test-utils/extension";
import { hasPermission, requestPermission } from "permission";

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
