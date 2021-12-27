import 'dart:collection';
import 'package:flutter/material.dart';
import 'entity.dart';

Relaxer relaxer = Relaxer(
    phone: "+375291197697",
    name: "Николай",
    surname: "Горбачев",
    gender: true
);

Set<Assignment> assignments = {
  Assignment(procedureName: "Процедура 1", begin: DateTime(2021,12,27, 1), end: DateTime(2021,12,27)),
  Assignment(procedureName: "Процедура 2", begin: DateTime(2021,12,27, 2), end: DateTime(2021,12,27)),
  Assignment(procedureName: "Процедура 3", begin: DateTime(2021,12,28, 1), end: DateTime(2021,12,28)),
  Assignment(procedureName: "Процедура 4", begin: DateTime(2021,12,28, 2), end: DateTime(2021,12,28)),
  Assignment(procedureName: "Процедура 5", begin: DateTime(2021,12,28, 3), end: DateTime(2021,12,28)),
  Assignment(procedureName: "Процедура 6", begin: DateTime(2021,12,28, 4), end: DateTime(2021,12,28)),
  Assignment(procedureName: "Процедура 7", begin: DateTime(2021,12,28, 5), end: DateTime(2021,12,28)),
  Assignment(procedureName: "Процедура 8", begin: DateTime(2021,12,28, 6), end: DateTime(2021,12,28)),
  Assignment(procedureName: "Процедура 9", begin: DateTime(2021,12,28, 7), end: DateTime(2021,12,28)),
  Assignment(procedureName: "Процедура 10", begin: DateTime(2021,12,28, 8), end: DateTime(2021,12,28)),
  Assignment(procedureName: "Процедура 11", begin: DateTime(2021,12,28, 9), end: DateTime(2021,12,28)),
  Assignment(procedureName: "Процедура 12", begin: DateTime(2021,12,28, 10), end: DateTime(2021,12,28)),
  Assignment(procedureName: "Процедура 13", begin: DateTime(2021,12,28, 11), end: DateTime(2021,12,28)),
  Assignment(procedureName: "Процедура 14", begin: DateTime(2021,12,28, 12), end: DateTime(2021,12,28)),
  Assignment(procedureName: "Процедура 15", begin: DateTime(2021,12,28, 13), end: DateTime(2021,12,28)),
  Assignment(procedureName: "Процедура 16", begin: DateTime(2021,12,28, 14), end: DateTime(2021,12,28)),
  Assignment(procedureName: "Процедура 17", begin: DateTime(2021,12,28, 15), end: DateTime(2021,12,28))
};

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
