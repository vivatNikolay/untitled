import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:untitled/src/tabs.dart';
import 'package:http/http.dart' as http;

void main() {
  // fetchData();
  runApp(const MyTabBar());
}

void fetchData() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
  log('\n Start ${response.body} End \n');
}

class MyTabBar extends StatelessWidget {
  const MyTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: MyTabController(),
    );
  }
}