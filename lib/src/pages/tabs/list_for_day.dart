import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/assignment_bean.dart';

class ListForDay extends StatefulWidget {
  List<AssignmentBean> assignments;
  ListForDay(this.assignments, {Key? key}) : super(key: key);

  @override
  _ListForDayState createState() => _ListForDayState(assignments);
}

class _ListForDayState extends State<ListForDay> {

  late List<AssignmentBean> assignments;

  _ListForDayState(this.assignments);

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