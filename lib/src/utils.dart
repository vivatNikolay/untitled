import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'entity.dart';

Relaxer relaxer = Relaxer(
    phone: "+375291197697",
    name: "Nick",
    surname: "Gorbachev",
    gender: true
);

Set<Assignment> assignments = {
  Assignment(procedureName: "Procedure1", begin: DateTime(2021,12,14, 1), end: DateTime(2021,12,14)),
  Assignment(procedureName: "Procedure2", begin: DateTime(2021,12,14, 2), end: DateTime(2021,12,14)),
  Assignment(procedureName: "Procedure3", begin: DateTime(2021,12,15, 1), end: DateTime(2021,12,15)),
  Assignment(procedureName: "Procedure4", begin: DateTime(2021,12,15, 2), end: DateTime(2021,12,15)),
  Assignment(procedureName: "Procedure5", begin: DateTime(2021,12,15, 3), end: DateTime(2021,12,15)),
  Assignment(procedureName: "Procedure6", begin: DateTime(2021,12,15, 4), end: DateTime(2021,12,15)),
  Assignment(procedureName: "Procedure7", begin: DateTime(2021,12,15, 5), end: DateTime(2021,12,15)),
  Assignment(procedureName: "Procedure8", begin: DateTime(2021,12,15, 6), end: DateTime(2021,12,15)),
  Assignment(procedureName: "Procedure9", begin: DateTime(2021,12,15, 7), end: DateTime(2021,12,15)),
  Assignment(procedureName: "Procedure10", begin: DateTime(2021,12,15, 8), end: DateTime(2021,12,15)),
  Assignment(procedureName: "Procedure11", begin: DateTime(2021,12,15, 9), end: DateTime(2021,12,15)),
  Assignment(procedureName: "Procedure12", begin: DateTime(2021,12,15, 10), end: DateTime(2021,12,15)),
  Assignment(procedureName: "Procedure13", begin: DateTime(2021,12,15, 11), end: DateTime(2021,12,15)),
  Assignment(procedureName: "Procedure14", begin: DateTime(2021,12,15, 12), end: DateTime(2021,12,15)),
  Assignment(procedureName: "Procedure15", begin: DateTime(2021,12,15, 13), end: DateTime(2021,12,15)),
  Assignment(procedureName: "Procedure16", begin: DateTime(2021,12,15, 14), end: DateTime(2021,12,15)),
  Assignment(procedureName: "Procedure17", begin: DateTime(2021,12,15, 15), end: DateTime(2021,12,15))
};

final DateFormat formatTime = DateFormat('HH:mm');
final kToday = DateTime.now();
final kTomorrow = DateTime(kToday.year, kToday.month, kToday.day + 1);
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

List<Assignment> getAssignmentsByDay(DateTime day) {
  Set<Assignment> assignmentsSorted =
  SplayTreeSet.from(assignments, (Assignment a, Assignment b) => a.begin.compareTo(b.begin));
  assignmentsSorted.removeWhere((el) => !DateUtils.isSameDay(el.begin, day));
  return assignmentsSorted.toList();
}
