const lib = require("./..");

async function main() {
  const ext = new lib.ExtensionManager("./../../testextensions");

  const exts = await ext.getExtensions();
  console.log(exts);

  for (const ext of exts) {
    console.log(ext);
    await ext.setEnabled(true);
    console.log(await ext.getEnabled());
    await ext.setSetting("someid", {
      type: "String",
      val: "othervalue",
      default_val: "somedefault",
    });
    console.log("\n\nSetting:");
    console.log(await ext.getSetting("someid"));

    console.log("\n\nBrowse:");
    const entries = await ext.browse(0, "Popular");
    for (const entry of entries) {
      console.log(entry);
    }
    console.log("\n\nSearch:");
    const search = await ext.search(0, "some");
    for (const entry of search) {
      console.log(entry);
    }
    console.log("\n\nDetail:");
    const detail = await ext.detail("someid");
    console.log(detail);
    console.log("\n\nSource:");
    const source = await ext.source("someid");
    console.log(source);
  }
}
main();
