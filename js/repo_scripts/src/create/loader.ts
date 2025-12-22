import { file } from "bun";

export async function loadTemplate(name: string): Promise<string> {
	return file(`templates/${name}.hbs`).text();
}
