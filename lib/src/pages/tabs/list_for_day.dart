import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../services/assignment_service.dart';

class ListForDay extends StatefulWidget {
  DateTime day;
  ListForDay(this.day, {Key? key}) : super(key: key);

  @override
  _ListForDayState createState() => _ListForDayState(day);
}

class _ListForDayState extends State<ListForDay> {
  DateTime day;
  _ListForDayState(this.day);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatTime = DateFormat('HH:mm');
    if (getAssignmentsByDay(day).isEmpty) {
      return const Center(
          child: Text("По расписанию ничего нет",
            style: TextStyle(
                color: Color(0xFF7B7B7B),
                fontSize: 19.0,
                fontFamily: 'TimesNewRoman'),
          )
      );
    }
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