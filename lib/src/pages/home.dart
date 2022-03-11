import 'package:flutter/material.dart';
import 'package:untitled/src/pages/drawer.dart';
import 'package:untitled/src/pages/tabs/list_for_day.dart';
import 'package:untitled/src/services/assignment_service.dart';
import 'tabs/calendar.dart';

class MyHomePage extends StatefulWidget {
  final String title = 'Расписание';
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Сегодня'),
              Tab(text: 'Завтра'),
              Tab(icon: Icon(Icons.calendar_today_rounded)),
            ],
            indicatorColor: Colors.blueGrey
          ),
        ),
        body: Center(
            child: TabBarView(children: [
              ListForDay(kToday),
              ListForDay(kTomorrow),
              const TableAssignments()
            ])
        ),
        drawer: MyDrawer(),
      ),
    );
  }
}