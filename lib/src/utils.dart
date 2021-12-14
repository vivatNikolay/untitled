// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'entity.dart';

Relaxer relaxer = Relaxer(
    phone: "+375291197697",
    name: "Nick",
    surname: "Gorbachev",
    gender: true
);

Set<Assignment> assignments = {
  Assignment(procedureName: "Procedure1", begin: DateTime(2021,12,13, 1), end: DateTime(2021,12,13)),
  Assignment(procedureName: "Procedure2", begin: DateTime(2021,12,13, 2), end: DateTime(2021,12,13)),
  Assignment(procedureName: "Procedure3", begin: DateTime(2021,12,14, 1), end: DateTime(2021,12,14)),
  Assignment(procedureName: "Procedure4", begin: DateTime(2021,12,14, 2), end: DateTime(2021,12,14)),
  Assignment(procedureName: "Procedure5", begin: DateTime(2021,12,14, 3), end: DateTime(2021,12,14)),
  Assignment(procedureName: "Procedure6", begin: DateTime(2021,12,14, 4), end: DateTime(2021,12,14)),
  Assignment(procedureName: "Procedure7", begin: DateTime(2021,12,14, 5), end: DateTime(2021,12,14)),
  Assignment(procedureName: "Procedure8", begin: DateTime(2021,12,14, 6), end: DateTime(2021,12,14)),
  Assignment(procedureName: "Procedure9", begin: DateTime(2021,12,14, 7), end: DateTime(2021,12,14)),
  Assignment(procedureName: "Procedure10", begin: DateTime(2021,12,14, 8), end: DateTime(2021,12,14)),
  Assignment(procedureName: "Procedure11", begin: DateTime(2021,12,14, 9), end: DateTime(2021,12,14)),
  Assignment(procedureName: "Procedure12", begin: DateTime(2021,12,14, 10), end: DateTime(2021,12,14)),
  Assignment(procedureName: "Procedure13", begin: DateTime(2021,12,14, 11), end: DateTime(2021,12,14)),
  Assignment(procedureName: "Procedure14", begin: DateTime(2021,12,14, 12), end: DateTime(2021,12,14)),
  Assignment(procedureName: "Procedure15", begin: DateTime(2021,12,14, 13), end: DateTime(2021,12,14)),
  Assignment(procedureName: "Procedure16", begin: DateTime(2021,12,14, 14), end: DateTime(2021,12,14)),
  Assignment(procedureName: "Procedure17", begin: DateTime(2021,12,14, 15), end: DateTime(2021,12,14))
};

final DateFormat formatTime = DateFormat('HH:mm');
DateTime todayDate = DateTime.now();
DateTime tomorrow = DateTime(todayDate.year, todayDate.month, todayDate.day + 1);

List<Assignment> getAssignmentsByDay(DateTime day) {
  Set<Assignment> assignmentsSorted =
  SplayTreeSet.from(assignments, (Assignment a, Assignment b) => a.begin.compareTo(b.begin));
  assignmentsSorted.removeWhere((el) => !DateUtils.isSameDay(el.begin, day));
  return assignmentsSorted.toList();
}
/// Example event class.
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}


final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
