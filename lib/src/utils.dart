import 'dart:collection';
import 'package:flutter/material.dart';
import 'models/assignment.dart';


Set<Assignment> assignments = {
  Assignment(procedureName: "Процедура 1", begin: DateTime(2022,2,11, 1), end: DateTime(2022,2,11)),
  Assignment(procedureName: "Процедура 2", begin: DateTime(2022,2,11, 2), end: DateTime(2022,2,11)),
  Assignment(procedureName: "Процедура 3", begin: DateTime(2022,2,12, 1), end: DateTime(2022,2,12)),
  Assignment(procedureName: "Процедура 4", begin: DateTime(2022,2,12, 2), end: DateTime(2022,2,12)),
  Assignment(procedureName: "Процедура 5", begin: DateTime(2022,2,12, 3), end: DateTime(2022,2,12)),
  Assignment(procedureName: "Процедура 6", begin: DateTime(2022,2,12, 4), end: DateTime(2022,2,12)),
  Assignment(procedureName: "Процедура 7", begin: DateTime(2022,2,12, 5), end: DateTime(2022,2,12)),
  Assignment(procedureName: "Процедура 8", begin: DateTime(2022,2,12, 6), end: DateTime(2022,2,12)),
  Assignment(procedureName: "Процедура 9", begin: DateTime(2022,2,12, 7), end: DateTime(2022,2,12)),
  Assignment(procedureName: "Процедура 10", begin: DateTime(2022,2,12, 8), end: DateTime(2022,2,12)),
  Assignment(procedureName: "Процедура 11", begin: DateTime(2022,2,12, 9), end: DateTime(2022,2,12)),
  Assignment(procedureName: "Процедура 12", begin: DateTime(2022,2,12, 10), end: DateTime(2022,2,12)),
  Assignment(procedureName: "Процедура 13", begin: DateTime(2022,2,12, 11), end: DateTime(2022,2,12)),
  Assignment(procedureName: "Процедура 14", begin: DateTime(2022,2,12, 12), end: DateTime(2022,2,12)),
  Assignment(procedureName: "Процедура 15", begin: DateTime(2022,2,12, 13), end: DateTime(2022,2,12)),
  Assignment(procedureName: "Процедура 16", begin: DateTime(2022,2,12, 14), end: DateTime(2022,2,12)),
  Assignment(procedureName: "Процедура 17", begin: DateTime(2022,2,12, 15), end: DateTime(2022,2,12))
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
