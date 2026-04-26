import 'package:flutter/material.dart';
import 'package:rdion_runtime/rdion_runtime.dart' as rdion;

import 'playground.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await rdion.RustLib.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dion Runtime Playground',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Playground(),
    );
  }
}