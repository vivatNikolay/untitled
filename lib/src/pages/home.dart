import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../controllers/controller.dart';
import '../helpers/enums.dart';
import '../models/assignment.dart';
import '../models/relaxer.dart';
import '../models/assignment_bean.dart';
import 'tabs/list_for_day.dart';
import 'tabs/calendar.dart';
import 'tab_manager.dart';
import 'drawer.dart';

class MyHomePage extends StatefulWidget {
  final String title = 'Расписание';

  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final Controller _httpController;
  late DateTime _today;
  late DateTime _tomorrow;
  late Relaxer relaxer;
  late TabManager _tabManager;
  late ValueNotifier<List<AssignmentBean>> todayAssignments;
  late ValueNotifier<List<AssignmentBean>> tomorrowAssignments;
  late ValueNotifier<List<Assignment>> assignments;
  late bool _isButtonActive;

  @override
  void initState() {
    super.initState();

    _httpController = Controller.instance;
    _today = DateTime.now();
    _tomorrow = DateTime(_today.year, _today.month, _today.day + 1);
    relaxer = _httpController.getActiveRelaxer();
    _tabManager = TabManager.instance;
    assignments = ValueNotifier(_httpController.getAssignments());
    todayAssignments = ValueNotifier(_tabManager.getAssignmentBeansByDay(_today, assignments.value));
    tomorrowAssignments = ValueNotifier(_tabManager.getAssignmentBeansByDay(_tomorrow, assignments.value));
    _isButtonActive = true;
    _tabManager.makeNotifications(assignments.value);
  }

  @override
  void dispose() {
    todayAssignments.dispose();
    tomorrowAssignments.dispose();
    assignments.dispose();
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
                  onPressed: _isButtonActive ? () async {
                    setState(() {
                      _isButtonActive = false;
                    });
                    await updateAction();
                    setState(() {
                      _isButtonActive = true;
                    });
                  }
                  : null,
                  icon: const Icon(Icons.refresh),
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
              TableAssignments(assignments)
        ])),
        drawer: MyDrawer(),
      ),
    );
  }

  Future<void> updateAction() async {
    _httpController.fetchAssignments(relaxer.sanatorium, relaxer.email);
    await wait();

    if (_httpController.getStateUpdate() == ResponseState.success) {
      _httpController.updateAssignments();
      assignments.value = _httpController.getAssignments();
      todayAssignments.value =
          _tabManager.getAssignmentBeansByDay(
              _today, assignments.value);
      tomorrowAssignments.value =
          _tabManager.getAssignmentBeansByDay(
              _tomorrow, assignments.value);
      _tabManager.makeNotifications(assignments.value);
    } else if (_httpController.getStateUpdate() == ResponseState.no_connection) {
      Fluttertoast.showToast(msg: "Проверьте интернет соединение");
    } else {
      Fluttertoast.showToast(msg: "Ошибка");
    }
  }

  Future<void> wait() async {
    int chanceCount = 5;
    for (int i = 0; i < chanceCount; i++) {
      if (_httpController.getStateUpdate() != ResponseState.processing) {
        break;
      }
      await Future.delayed(const Duration(seconds: 1));
    }
  }
}
