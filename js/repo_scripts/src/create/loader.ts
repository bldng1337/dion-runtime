import { file } from "bun";
import { join } from "node:path";

export async function loadTemplate(name: string): Promise<string> {
	return file(join(import.meta.dir, `../../templates/${name}.hbs`)).text();
}
