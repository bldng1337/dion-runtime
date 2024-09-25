import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rdion_runtime/rdion_runtime.dart';

Future<void> main() async {
  await RustLib.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Directory current = Directory.current;
    print('current directory: ${current.path}');
    final em = ExtensionManagerProxy();
    em.addFromFile(path: "../../../testextensions/test.dion.js");
    em.iter().then((value) async {
      for(var extension in value) {
        // print('extension: ${extension.enable()}');
        // rustFunction(dartCallback: (permission) {
        //   print("Asked for Permission");
        //   return true;
        // });
        
        setPermissionRequest((permission) {
          print("Testing permission request");
          print("Path: ${(permission.permission as Permission_StoragePermission).path}");
          return true;
        });
        await extension.enable();
        final entries=await extension.browse(page: 1, sort: Sort.popular);
        final entry=await extension.detail(entry: entries[0]);
        final source=await extension.source(ep: entry.episodes[0].episodes[0]);
        switch(source) {
          case final Source_Data source:
            switch(source.sourcedata) {
              case final DataSource_Paragraphlist source:
                print('source: paragraphlist ${source.paragraphs.length}');
                break;
            }
            break;
          case final Source_Directlink source:
            switch(source.sourcedata) {
              case final LinkSource_Epub source:
                print('source: epub ${source.link}');
                break;
              case final LinkSource_Pdf source:
                print('source: pdf ${source.link}');
                break;
              case final LinkSource_Imagelist source:
                print('source: imagelist ${source.links.length}');
                break;
              case final LinkSource_M3u8 source:
                print('source: m3u8 ${source.link}');
                break;
            } 
            break;
        }
      }
    });
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('flutter_rust_bridge quickstart')),
        body: const Center(
          child: Text(
              'Action: Call Rust `greet("Tom")`\nResult: '),
        ),
      ),
    );
  }
}
