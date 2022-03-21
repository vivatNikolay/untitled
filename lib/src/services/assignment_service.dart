import 'package:flutter/material.dart';
import 'package:untitled/src/models/assignment_bean.dart';
import '../../boxes.dart';
import '../models/assignment.dart';
import '../models/date_time_interval.dart';

class AssignmentService {

  final boxAssignments = Boxes.getAssignment();

  List<AssignmentBean> getAssignmentsByDay(DateTime day) {
    List<Assignment> list = boxAssignments.values.toList();
    List<AssignmentBean> assignmentBeans = [];
    for (Assignment el in list) {
      for (DateTimeInterval interval in el.intervals) {
        assignmentBeans.add(
            AssignmentBean(el.procedureName, interval.begin, interval.end));
      }
    }
    assignmentBeans.removeWhere((el) => !DateUtils.isSameDay(el.begin, day));
    assignmentBeans.sort((AssignmentBean a, AssignmentBean b) =>
        a.begin.compareTo(b.begin));

    return assignmentBeans;
  }

  void addAll(Iterable<Assignment> assignments) {
    boxAssignments.clear();
    boxAssignments.addAll(assignments);
  }

  void delete() {
    boxAssignments.clear();
  }
}