import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../helpers/constants.dart';

class ListForDay extends StatefulWidget {
  var assignments;
  ListForDay(this.assignments, {Key? key}) : super(key: key);

  @override
  _ListForDayState createState() => _ListForDayState(assignments);
}

class _ListForDayState extends State<ListForDay> {
  var assignments;

  _ListForDayState(this.assignments);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatTime = DateFormat('HH:mm');
    if (assignments.value.isEmpty) {
      return const Center(
          child: Text("Процедур нет",
            style: TextStyle(
                color: emptyTextColor,
                fontSize: 19.0,
                fontFamily: 'TimesNewRoman'),
          )
      );
    }
    return ValueListenableBuilder<List<dynamic>>(
        valueListenable: assignments,
        builder: (context, value, _) {
          return ListView.builder(
            itemCount: value.length,
            itemBuilder: (_, index) {
            return Card(
              shadowColor: shadowColor,
              elevation: 4.0,
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: ListTile(
                leading: Column(
                  children: [
                    Text(
                        formatTime.format(value[index].begin),
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                ),
                title: Text(value[index].procedureName),
                subtitle: Text(value[index].medRoom),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
              ),
            );
          });
    });
  }
}