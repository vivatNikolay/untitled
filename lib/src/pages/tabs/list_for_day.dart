import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled/src/controllers/controller.dart';

import '../../models/assignment_bean.dart';
import '../../services/assignment_service.dart';

class ListForDay extends StatefulWidget {
  DateTime day;
  ListForDay(this.day, {Key? key}) : super(key: key);

  @override
  _ListForDayState createState() => _ListForDayState(day);
}

class _ListForDayState extends State<ListForDay> {

  late final HttpController _httpController;
  late List<AssignmentBean> _assignments;
  DateTime day;
  _ListForDayState(this.day);

  @override
  void initState() {
    super.initState();

    _httpController = HttpController.instance;
    _assignments = _httpController.getAssignmentsByDay(day);
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatTime = DateFormat('HH:mm');
    if (_assignments.isEmpty) {
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
        itemCount: _assignments.length,
        itemBuilder: (_, index) {
          return Card(
            shadowColor: const Color(0xFF75AAA1),
            elevation: 4.0,
            child: ListTile(
              title: Text(_assignments[index].procedureName),
              subtitle: Text(
                  formatTime.format(_assignments[index].begin)),
              trailing: const Icon(Icons.more_vert),
            ),
          );
        });
  }
}