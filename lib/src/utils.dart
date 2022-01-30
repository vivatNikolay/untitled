import 'dart:collection';
import 'package:flutter/material.dart';
import 'models/assignment.dart';


Set<Assignment> assignments = {
  Assignment(procedureName: "Процедура 1", begin: DateTime(2022,1,30, 1), end: DateTime(2022,1,30)),
  Assignment(procedureName: "Процедура 2", begin: DateTime(2022,1,30, 2), end: DateTime(2022,1,30)),
  Assignment(procedureName: "Процедура 3", begin: DateTime(2022,1,31, 1), end: DateTime(2022,1,31)),
  Assignment(procedureName: "Процедура 4", begin: DateTime(2022,1,31, 2), end: DateTime(2022,1,31)),
  Assignment(procedureName: "Процедура 5", begin: DateTime(2022,1,31, 3), end: DateTime(2022,1,31)),
  Assignment(procedureName: "Процедура 6", begin: DateTime(2022,1,31, 4), end: DateTime(2022,1,31)),
  Assignment(procedureName: "Процедура 7", begin: DateTime(2022,1,31, 5), end: DateTime(2022,1,31)),
  Assignment(procedureName: "Процедура 8", begin: DateTime(2022,1,31, 6), end: DateTime(2022,1,31)),
  Assignment(procedureName: "Процедура 9", begin: DateTime(2022,1,31, 7), end: DateTime(2022,1,31)),
  Assignment(procedureName: "Процедура 10", begin: DateTime(2022,1,31, 8), end: DateTime(2022,1,31)),
  Assignment(procedureName: "Процедура 11", begin: DateTime(2022,1,31, 9), end: DateTime(2022,1,31)),
  Assignment(procedureName: "Процедура 12", begin: DateTime(2022,1,31, 10), end: DateTime(2022,1,31)),
  Assignment(procedureName: "Процедура 13", begin: DateTime(2022,1,31, 11), end: DateTime(2022,1,31)),
  Assignment(procedureName: "Процедура 14", begin: DateTime(2022,1,31, 12), end: DateTime(2022,1,31)),
  Assignment(procedureName: "Процедура 15", begin: DateTime(2022,1,31, 13), end: DateTime(2022,1,31)),
  Assignment(procedureName: "Процедура 16", begin: DateTime(2022,1,31, 14), end: DateTime(2022,1,31)),
  Assignment(procedureName: "Процедура 17", begin: DateTime(2022,1,31, 15), end: DateTime(2022,1,31))
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
