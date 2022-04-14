import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:untitled/src/models/assignment_bean.dart';
import 'package:untitled/src/pages/tabs/tab_helper.dart';
import '../../models/assignment.dart';

class TableAssignments extends StatefulWidget {
  var assignments;
  TableAssignments(this.assignments, {Key? key}) : super(key: key);

  @override
  _TableAssignmentsState createState() => _TableAssignmentsState(assignments);
}

class _TableAssignmentsState extends State<TableAssignments> {

  final _kFirstDay = DateTime(DateTime.now().year, DateTime.now().month - 3, DateTime.now().day);
  final _kLastDay = DateTime(DateTime.now().year, DateTime.now().month + 3, DateTime.now().day);
  late final ValueNotifier<List<AssignmentBean>> _selectedAssignmentBeans;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  late final RangeSelectionMode _rangeSelectionMode;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late ValueNotifier<List<Assignment>> assignments;
  late TabHelper tabHelper;

  _TableAssignmentsState(this.assignments);

  @override
  void initState() {
    super.initState();

    tabHelper = TabHelper();
    _selectedDay = _focusedDay;
    _selectedAssignmentBeans = ValueNotifier(_getAssignmentsForDay(_selectedDay!));
    _rangeSelectionMode = RangeSelectionMode.toggledOff;
    assignments.addListener(_updateAssignments);
  }
  void _updateAssignments() {
    _selectedAssignmentBeans.value = _getAssignmentsForDay(_selectedDay!);
  }

  @override
  void dispose() {
    assignments.removeListener(_updateAssignments);
    _selectedAssignmentBeans.dispose();
    super.dispose();
  }

  List<AssignmentBean> _getAssignmentsForDay(DateTime day) {
    return tabHelper.getAssignmentBeansByDay(day, assignments.value);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedAssignmentBeans.value = _getAssignmentsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TableCalendar<AssignmentBean>(
            //locale: 'en_US',
            firstDay: _kFirstDay,
            lastDay: _kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getAssignmentsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: const CalendarStyle(
              outsideDaysVisible: true,
              weekendTextStyle: TextStyle(color: Color(0xFFBA1818)),
              selectedDecoration : BoxDecoration(
                color: Color(0xFF75AAA1),
                shape: BoxShape.circle,
              ),
              todayDecoration:  BoxDecoration(
                color: Color(0xFFACCDC8),
                shape: BoxShape.circle,
              ),
            ),
            onDaySelected: _onDaySelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 4.0),
          Expanded(
            child: ValueListenableBuilder<List<AssignmentBean>>(
              valueListenable: _selectedAssignmentBeans,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemExtent: 72,
                  itemBuilder: (context, index) {
                    final DateFormat formatTime = DateFormat('HH:mm');
                    return Card(
                      shadowColor: const Color(0xFF75AAA1),
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.0),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: ListTile(
                        leading: Container(
                          margin: const EdgeInsets.only(top: 6),
                          child: Text(
                              formatTime.format(value[index].begin),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                        ),
                        title: Text(value[index].procedureName),
                        subtitle: Text(value[index].medRoom),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10.0),
                        isThreeLine: true,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
