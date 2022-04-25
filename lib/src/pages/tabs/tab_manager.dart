import 'package:flutter/material.dart';
import '../../models/assignment.dart';
import '../../models/assignment_bean.dart';
import '../../models/date_time_interval.dart';

class TabManager {
  List<AssignmentBean> getAssignmentBeansByDay(DateTime day, List<Assignment> list) {
    List<AssignmentBean> assignmentBeans = [];
    for (Assignment el in list) {
      for (DateTimeInterval interval in el.intervals) {
        assignmentBeans.add(
            AssignmentBean(el.procedureName, interval.begin, interval.end, interval.medRoom));
      }
    }
    assignmentBeans.removeWhere((el) => !DateUtils.isSameDay(el.begin, day));
    assignmentBeans.sort((AssignmentBean a, AssignmentBean b) =>
        a.begin.compareTo(b.begin));

    return assignmentBeans;
  }

}