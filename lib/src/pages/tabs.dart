import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/src/http_controller.dart';
import 'package:untitled/src/models/relaxer.dart';
import 'package:untitled/src/pages/drawer.dart';
import 'package:untitled/src/utils.dart';
import 'calendar.dart';

class MyHomePage extends StatefulWidget {
  final String title = 'Расписание';
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final HttpController _httpController = HttpController.instance;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: const TabBar(tabs: [
            Tab(text: 'Сегодня'),
            Tab(text: 'Завтра'),
            Tab(icon: Icon(Icons.calendar_today_rounded)),
          ],),
        ),
        body: Center(
            child: TabBarView(children: [
              listView(kToday),
              listView(kTomorrow),
              const TableAssignments()
            ])
        ),
        drawer: MyDrawer(relaxer: _httpController.getRelaxer()),
      ),
    );
  }

  ListView listView(DateTime day) {
    final DateFormat formatTime = DateFormat('HH:mm');
    return ListView.builder(
        itemCount: getAssignmentsByDay(day).length,
        itemBuilder: (_, index) {
          return Card(
            shadowColor: Colors.deepPurple,
            elevation: 4.0,
            child: ListTile(
              title: Text(getAssignmentsByDay(day)[index].procedureName),
              subtitle: Text(
                  formatTime.format(getAssignmentsByDay(day)[index].begin)),
              trailing: const Icon(Icons.more_vert),
            ),
          );
        });
  }
}