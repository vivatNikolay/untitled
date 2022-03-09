import 'package:flutter/material.dart';
import 'package:untitled/src/models/assignment_bean.dart';
import '../controller.dart';
import '../models/assignment.dart';
import '../models/date_time_interval.dart';

final HttpController _httpController = HttpController.instance;

final kToday = DateTime.now();
final kTomorrow = DateTime(kToday.year, kToday.month, kToday.day + 1);
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

List<AssignmentBean> getAssignmentsByDay(DateTime day) {
  List<AssignmentBean> assignmentBeans = [];
  List<Assignment> _listOfAssignments = _httpController.getAssignments();
  for (Assignment el in _listOfAssignments) {
    for (DateTimeInterval interval in el.intervals) {
      assignmentBeans.add(AssignmentBean(el.procedureName, interval.begin, interval.end));
    }
  }
  assignmentBeans.removeWhere((el) => !DateUtils.isSameDay(el.begin, day));
  assignmentBeans.sort((AssignmentBean a, AssignmentBean b) =>
    a.begin.compareTo(b.begin));

  return assignmentBeans;
}
