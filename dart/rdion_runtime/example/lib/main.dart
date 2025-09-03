// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_json_view/flutter_json_view.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:rdion_runtime/rdion_runtime.dart';

// //Id rather read it from file system but to make it run even on external devices(mobile) Im packing it in the code
// const String testextension = r"""
// //{"id":"123","repo":"repo","icon":"https://9animetv.to/images/favicon.png","name":"9Anime","version":"1.0.0","description":"A Anime Streaming Site","author":"","license":"0BSD","keywords":["anime","series"],"nsfw":false,"lang":["en"],"media_type":["Video"],"url":"https://9animetv.to"}
// /// <reference path="../rust/core/bindings/index.d.ts" />
// import { decode_base64, encode_base64 } from "convert";
// import { fetch } from "network";
// import { parse_html } from "parse";
// import { getSetting, registerSetting } from "setting";
// function test() {
//   console.log("external test");
//   return true;
// }

// function assert(condition, msg = "Extension error") {
//   if (!condition) {
//     throw new Error(`Assert failed: ${msg}`);
//   }
// }
// /**
//  *
//  * @returns {Entry}
//  */
// function getEntry() {
//   return {
//     id: "someid",
//     url: "someurl",
//     title: "sometext",
//     media_type: "Video",
//     cover: "somecover",
//     cover_header: { some: "header" },
//     author: ["someauther"],
//     rating: 0.5,
//     views: 100,
//     length: 1000,
//   };
// }

// /**
//  *
//  * @returns {Episode}
//  */
// function getEpisode() {
//   return {
//     id: "someid",
//     name: "sometext",
//     url: "someurl",
//     cover: "somecover",
//     cover_header: { some: "header" },
//     timestamp: "somedate",
//   };
// }

// /**
//  *
//  * @returns {EntryDetailed}
//  */
// function getEntryDetailed() {
//   return {
//     id: "someid",
//     url: "someurl",
//     title: "sometext",
//     media_type: "Video",
//     status: "Complete",
//     language: "somelanguage",
//     description: "somedescription",
//     cover: "somecover",
//     cover_header: { some: "header" },
//     episodes: [getEpisode()],
//     genres: ["somegenre"],
//     alttitles: ["somealttitle"],
//     author: ["someauther"],
//     rating: 0.5,
//     views: 100,
//     length: 1000,
//   };
// }

// /**
//  *
//  * @returns {Source}
//  */
// function getSource() {
//   return {
//     sourcetype: "Directlink",
//     sourcedata: {
//       type: "Epub",
//       link: "epid",
//     },
//   };
// }

// export default class {
//   constructor() {
//     this.test = "some test";
//   }

//   async load() {
//     // TODO: Finish Implementing permissions
//     // {
//     //   const permission = await requestPermission(
//     //     { id: "storage", path: "some" },
//     //     "some permission"
//     //   );
//     //   assert(permission == true, "permission not working");
//     // }
//     // {
//     //   const permission = await requestPermission(
//     //     { id: "storage", path: "other" },
//     //     "other"
//     //   );
//     //   assert(permission == false, "permission not working");
//     // }

//     console.log("other");
//     assert(decode_base64("YXNk") == "asd", "decode_base64 not working");
//     assert(encode_base64("asd") == "YXNk", "encode_base64 not working");
//     assert(
//       decode_base64(encode_base64("test")) == "test",
//       "decode_base64 or encode_base64 not working"
//     );
//     console.log({ some: "test" });
//     assert(test() == true, "external function not working");
//     const res = await fetch("https://www.example.com");
//     assert(res.body.length > 0, "fetch not working");

//     let setting = {
//       settingtype: "Extension",
//       setting: {
//         val: {
//           type: "String",
//           val: "somevalue",
//           default_val: "somedefault",
//         },
//         ui: {
//           type: "Textbox",
//           label: "somelabel",
//         },
//       },
//     };
//     await registerSetting("someid", setting);
//     console.log(JSON.stringify(await getSetting("someid")));
//     // await fetch("https://www.google.com");
//     // const cookies = await getCookies();
//     // assert(cookies.length > 0, "cookies not working");
//     // parse_html(res.body);
//     let html = `<html><body><div attr="value">some text</div><div>some other text</div></body></html>`;
//     let parsed = parse_html(html);
//     let sel = new CSSSelector("div");
//     let elarr = parsed.select(sel);
//     let el = elarr.first;
//     console.log(el.text);
//     assert(el.text == "some text", "parse_html not working");
//     assert(el.parent.name == "body", "parse_html not working");
//     assert(el.name == "div", "parse_html not working");
//     assert(el.attr("attr") == "value", "parse_html not working");
//     assert(elarr.length == 2, "parse_html not working");
//     assert(
//       elarr.map((el) => el.text).join("\n") == "some text\nsome other text",
//       "parse_html not working"
//     );
//     console.log("paragraphs");
//     console.log(elarr.paragraphs.join("\n"));
//     assert(
//       elarr.paragraphs.join("\n") == "some text\nsome other text",
//       "parse_html not working"
//     );
//   }

//   async browse(page, sort) {
//     assert(typeof page == "number", "page must be a number");
//     assert(typeof sort == "string", "sort must be a string");
//     return [getEntry()];
//   }
//   async search(page, filter) {
//     assert(typeof page == "number", "page must be a number");
//     assert(typeof filter == "string", "filter must be a string");
//     return [getEntry()];
//   }
//   async detail(entryid) {
//     assert(entryid == "someid", "entryid is wrong");
//     assert(typeof entryid == "string", "entryid must be a string");
//     return getEntryDetailed();
//   }
//   async source(epid) {
//     assert(typeof epid == "string", "epid must be a string");
//     return getSource();
//   }
// }
// """;

// late final SourceExtensionManagerProxy manager;
// late final SourceExtensionProxy extension;
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await RustLib.init();
//   final path = await getApplicationDocumentsDirectory();
//   final extdir = Directory("${path.path}/testextensions");
//   extdir.createSync(recursive: true);
//   final extfile = File("${extdir.path}/test.dion.js");
//   extfile.writeAsStringSync(testextension);
//   manager = SourceExtensionManagerProxy(path: extdir.path);
//   extension = (await manager.getExtensions()).first;
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Test')),
//         body: ListView(
//           children: const [
//             ExtensionState(),
//             BrowseTest(),
//             SearchTest(),
//             DetailTest(),
//             SourceTest(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ExtensionState extends StatefulWidget {
//   const ExtensionState({super.key});

//   @override
//   State<ExtensionState> createState() => _ExtensionStateState();
// }

// class _ExtensionStateState extends State<ExtensionState> {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: extension.isEnabled(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return Column(
//               children: [
//                 Text(snapshot.data! ? "Enabled" : "Disabled"),
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       if (snapshot.data!) {
//                         extension.setEnabled(enabled: false);
//                       } else {
//                         extension.setEnabled(enabled: true);
//                       }
//                     });
//                   },
//                   child: Text(snapshot.data! ? "Disable" : "Enable"),
//                 ),
//               ],
//             );
//           }
//           return const Center(child: CircularProgressIndicator());
//         });
//   }
// }

// class BrowseTest extends StatefulWidget {
//   const BrowseTest({super.key});

//   @override
//   State<BrowseTest> createState() => _BrowseTestState();
// }

// class _BrowseTestState extends State<BrowseTest> {
//   Future<List<Entry>>? future;
//   int page = 0;
//   Sort sort = Sort.popular;

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       const Text("Browse"),
//       const Text("Page"),
//       TextField(
//         onChanged: (value) {
//           try {
//             page = int.parse(value);
//             setState(() {});
//           } catch (e) {
//             print(e);
//           }
//         },
//       ),
//       const Text("Sort"),
//       DropdownButton<Sort>(
//         value: sort,
//         onChanged: (value) {
//           sort = value!;
//           setState(() {});
//         },
//         items: const [
//           DropdownMenuItem(
//             value: Sort.popular,
//             child: Text("Popular"),
//           ),
//           DropdownMenuItem(
//             value: Sort.latest,
//             child: Text("latest"),
//           ),
//           DropdownMenuItem(
//             value: Sort.updated,
//             child: Text("updated"),
//           ),
//         ],
//       ),
//       TextButton(
//         onPressed: () {
//           future = extension.browse(page: page, sort: sort);
//           setState(() {});
//         },
//         child: const Text("Browse"),
//       ),
//       FutureBuilder<List<Entry>>(
//         future: future,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return JsonView.map({
//               "list": snapshot.data!.map((e) => e.toJson()).toList(),
//             });
//           }
//           return const Center(child: CircularProgressIndicator());
//         },
//       ),
//     ]);
//   }
// }

// class SearchTest extends StatefulWidget {
//   const SearchTest({super.key});

//   @override
//   State<SearchTest> createState() => _SearchTestState();
// }

// class _SearchTestState extends State<SearchTest> {
//   Future<List<Entry>>? future;
//   int page = 0;
//   String filter = "";

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       const Text("Search"),
//       const Text("Filter"),
//       TextField(
//         onChanged: (value) {
//           filter = value;
//           setState(() {});
//         },
//       ),
//       const Text("Page"),
//       TextField(
//         onChanged: (value) {
//           try {
//             page = int.parse(value);
//             setState(() {});
//           } catch (e) {
//             print(e);
//           }
//         },
//       ),
//       TextButton(
//         onPressed: () {
//           future = extension.search(page: page, filter: filter);
//           setState(() {});
//         },
//         child: const Text("Search"),
//       ),
//       FutureBuilder<List<Entry>>(
//         future: future,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return JsonView.map({
//               "list": snapshot.data!.map((e) => e.toJson()).toList(),
//             });
//           }
//           return const Center(child: CircularProgressIndicator());
//         },
//       ),
//     ]);
//   }
// }

// class DetailTest extends StatefulWidget {
//   const DetailTest({super.key});

//   @override
//   State<DetailTest> createState() => _DetailTestState();
// }

// class _DetailTestState extends State<DetailTest> {
//   Future<EntryDetailed>? future;
//   String entryid = "";
//   Map<String, Setting> settings = {};

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       const Text("Detail"),
//       const Text("Entryid"),
//       TextField(
//         onChanged: (value) {
//           entryid = value;
//           setState(() {});
//         },
//       ),
//       TextButton(
//         onPressed: () {
//           future = extension.detail(entryid: entryid, settings: settings);
//           setState(() {});
//         },
//         child: const Text("Detail"),
//       ),
//       FutureBuilder<EntryDetailed>(
//         future: future,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return JsonView.map(snapshot.data!.toJson());
//           }
//           return const Center(child: CircularProgressIndicator());
//         },
//       ),
//     ]);
//   }
// }

// class SourceTest extends StatefulWidget {
//   const SourceTest({super.key});

//   @override
//   State<SourceTest> createState() => _SourceTestState();
// }

// class _SourceTestState extends State<SourceTest> {
//   Future<Source>? future;
//   String epid = "";
//   Map<String, Setting> settings = {};

//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       const Text("Source"),
//       const Text("Epid"),
//       TextField(
//         onChanged: (value) {
//           epid = value;
//           setState(() {});
//         },
//       ),
//       TextButton(
//         onPressed: () {
//           future = extension.source(epid: epid, settings: settings);
//           setState(() {});
//         },
//         child: const Text("Source"),
//       ),
//       FutureBuilder<Source>(
//         future: future,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return JsonView.map(snapshot.data!.toJson());
//           }
//           return const Center(child: CircularProgressIndicator());
//         },
//       ),
//     ]);
//   }
// }
