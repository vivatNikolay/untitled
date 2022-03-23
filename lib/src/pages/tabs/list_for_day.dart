import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/src/models/relaxer.dart';
import '../../controllers/controller.dart';
import '../../models/assignment_bean.dart';

class ListForDay extends StatefulWidget {
  DateTime day;
  ValueNotifier<bool> buttonClicked;
  ListForDay(this.day, this.buttonClicked, {Key? key}) : super(key: key);

  @override
  _ListForDayState createState() => _ListForDayState(day, buttonClicked);
}

class _ListForDayState extends State<ListForDay> {
  late final HttpController _httpController;
  late List<AssignmentBean> assignments;
  DateTime day;
  ValueNotifier<bool> buttonClicked;
  late Relaxer relaxer;

  _ListForDayState(this.day, this.buttonClicked);

  @override
  void initState() {
    super.initState();

    _httpController = HttpController.instance;
    assignments = _httpController.getAssignmentsByDay(day);
    relaxer = _httpController.getActiveRelaxer();
    buttonClicked.addListener(_updateListener);
  }

  Future<void> _updateListener() async {
    _httpController.deleteAssignments();
    _httpController.fetchAssignments(relaxer.sanatorium, relaxer.email);
    await Future.delayed(const Duration(seconds: 1));
    _httpController.updateAssignments();
    setState(() {
      assignments = _httpController.getAssignmentsByDay(day);
    });
  }

  @override
  void dispose() {
    buttonClicked.removeListener(_updateListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatTime = DateFormat('HH:mm');
    if (assignments.isEmpty) {
      return const Center(
          child: Text("Процедур нет",
            style: TextStyle(
                color: Color(0xFF7B7B7B),
                fontSize: 19.0,
                fontFamily: 'TimesNewRoman'),
          )
      );
    }
    return ListView.builder(
        itemCount: assignments.length,
        itemBuilder: (_, index) {
          return Card(
            shadowColor: const Color(0xFF75AAA1),
            elevation: 4.0,
            child: ListTile(
              title: Text(assignments[index].procedureName),
              subtitle: Text(
                  formatTime.format(assignments[index].begin)),
              trailing: const Icon(Icons.more_vert),
            ),
          );
        });
  }
}