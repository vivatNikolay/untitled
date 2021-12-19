import 'package:flutter/material.dart';
import 'package:untitled/src/drawer.dart';
import 'package:untitled/src/utils.dart';
import 'calendar.dart';

class MyHomePage extends StatefulWidget {
  final String title = 'Schedule';
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
          bottom: const TabBar(tabs: [
            Tab(text: 'Today'),
            Tab(text: 'Tomorrow'),
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
        drawer: MyDrawer(relaxer: relaxer),
      ),
    );
  }

  ListView listView(DateTime day) {
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