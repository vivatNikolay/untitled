import 'package:flutter/material.dart';
import '../../models/assignment.dart';
import '../../models/assignment_bean.dart';
import '../../models/date_time_interval.dart';
import '../../services/notification/notification_service.dart';

class TabManager {
  static final TabManager _instance = TabManager();

  static TabManager get instance => _instance;

  TabManager() {
    NotificationService.init();
  }

  List<AssignmentBean> getAssignmentBeansByDay(
      DateTime day, List<Assignment> list) {
    List<AssignmentBean> assignmentBeans = [];
    for (Assignment el in list) {
      for (DateTimeInterval interval in el.intervals) {
        assignmentBeans.add(AssignmentBean(
            el.procedureName, interval.begin, interval.end, interval.medRoom));
      }
    }
    assignmentBeans.removeWhere((el) => !DateUtils.isSameDay(el.begin, day));
    assignmentBeans.sort(
        (AssignmentBean a, AssignmentBean b) => a.begin.compareTo(b.begin));

    return assignmentBeans;
  }

  List<AssignmentBean> _getFirstAssignmentBeansInDay(List<Assignment> list) {
    List<AssignmentBean> assignmentBeans = [];
    for (Assignment el in list) {
      for (DateTimeInterval interval in el.intervals) {
        assignmentBeans.add(AssignmentBean(
            el.procedureName, interval.begin, interval.end, interval.medRoom));
      }
    }
    assignmentBeans.sort(
            (AssignmentBean a, AssignmentBean b) => a.begin.compareTo(b.begin));
    DateTime day = assignmentBeans.first.begin.subtract(Duration(days: -1));
    List<AssignmentBean> resultList = [];
    for (AssignmentBean el in assignmentBeans) {
      if (!DateUtils.isSameDay(el.begin, day)){
        resultList.add(el);
        day = el.begin;
      }
    }
    return resultList;
  }

  void makeNotifications(List<Assignment> assignments) {
    List<AssignmentBean> assignmentBeans = _getFirstAssignmentBeansInDay(assignments);
    if (assignmentBeans.isNotEmpty &&
        assignmentBeans.first.begin.isAfter(DateTime.now())) {
      NotificationService.showScheduledNotification(
          title: 'Умный санаторий',
          body: 'Через 10 минут назначение',
          scheduledDate: assignmentBeans.first.begin
              .subtract(const Duration(minutes: 10)));
    }
  }
}
