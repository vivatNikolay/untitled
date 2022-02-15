import 'dart:io';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:untitled/src/models/relaxer.dart';
import 'package:untitled/src/pages/login.dart';
import 'package:untitled/src/pages/tabs.dart';

import 'boxes.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides ();

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(RelaxerAdapter());
  await Hive.openBox<Relaxer>('relaxer');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    StatefulWidget home;
    if (Boxes.getRelaxer().isEmpty) {
      home = const LoginScreen();
    } else {
      home = const MyHomePage();
    }
    return MaterialApp(
      title: 'Scheduler',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: home,
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}