import 'package:flutter/material.dart';
import '../models/assignment.dart';
import '../models/assignment_bean.dart';
import '../models/date_time_interval.dart';
import '../services/notification/notification_service.dart';

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
    DateTime day = DateTime.now().subtract(const Duration(days: -1));
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
    NotificationService.cancelAll();
    List<AssignmentBean> assignmentBeans = _getFirstAssignmentBeansInDay(assignments);
    for(AssignmentBean bean in assignmentBeans) {
      if (bean.begin.isAfter(DateTime.now())) {
        NotificationService.showScheduledNotification(
            title: 'Умный санаторий',
            body: 'Через 10 минут назначение',
            scheduledDate: bean.begin
                .subtract(const Duration(minutes: 10)));
      }
    }
  }

  void cancelNotifications() {
    NotificationService.cancelAll();
  }
}
