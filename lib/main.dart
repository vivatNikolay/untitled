import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:untitled/src/login.dart';
import 'package:untitled/src/tabs.dart';
import 'package:http/http.dart' as http;

void main() {
  // fetchData();
  runApp(const MyApp());
}

void fetchData() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
  log('\n Start ${response.body} End \n');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scheduler',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: LoginScreen()
    );
  }
}