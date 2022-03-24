import 'package:flutter/material.dart';
import 'package:untitled/src/models/assignment_bean.dart';
import 'package:untitled/src/pages/drawer.dart';
import 'package:untitled/src/pages/tabs/list_for_day.dart';
import '../controllers/controller.dart';
import '../models/relaxer.dart';
import 'tabs/calendar.dart';

class MyHomePage extends StatefulWidget {
  final String title = 'Расписание';

  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DateTime _today;
  late DateTime _tomorrow;
  late final HttpController _httpController;
  late ValueNotifier<List<AssignmentBean>> todayAssignments;
  late ValueNotifier<List<AssignmentBean>> tomorrowAssignments;
  late Relaxer relaxer;

  @override
  void initState() {
    super.initState();

    _today = DateTime.now();
    _tomorrow = DateTime(_today.year, _today.month, _today.day + 1);
    _httpController = HttpController.instance;
    relaxer = _httpController.getActiveRelaxer();
    todayAssignments = ValueNotifier(_httpController.getAssignmentsByDay(_today));
    tomorrowAssignments = ValueNotifier(_httpController.getAssignmentsByDay(_tomorrow));
  }

  @override
  void dispose() {
    todayAssignments.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: IconButton(
                  onPressed: () async {
                    _httpController.deleteAssignments();
                    _httpController.fetchAssignments(relaxer.sanatorium, relaxer.email);
                    await Future.delayed(const Duration(seconds: 1));
                    _httpController.updateAssignments();
                    todayAssignments.value = _httpController.getAssignmentsByDay(_today);
                    tomorrowAssignments.value = _httpController.getAssignmentsByDay(_tomorrow);
                  },
                  icon: const Icon(Icons.update),
                )
            ),
          ],
          bottom: const TabBar(tabs: [
            Tab(text: 'Сегодня'),
            Tab(text: 'Завтра'),
            Tab(icon: Icon(Icons.calendar_today_rounded)),
          ], indicatorColor: Colors.blueGrey),
        ),
        body: Center(
            child: TabBarView(children: [
              ListForDay(todayAssignments),
              ListForDay(tomorrowAssignments),
              TableAssignments()
        ])),
        drawer: MyDrawer(),
      ),
    );
  }
}
