import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:untitled/src/models/assignment_bean.dart';
import '../../services/assignment_service.dart';

class TableAssignments extends StatefulWidget {
  const TableAssignments({Key? key}) : super(key: key);

  @override
  _TableAssignmentsState createState() => _TableAssignmentsState();
}

class _TableAssignmentsState extends State<TableAssignments> {
  late final ValueNotifier<List<AssignmentBean>> _selectedAssignmentBeans;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  late final RangeSelectionMode _rangeSelectionMode;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedAssignmentBeans = ValueNotifier(_getAssignmentsForDay(_selectedDay!));
    _rangeSelectionMode = RangeSelectionMode.toggledOff;
  }

  @override
  void dispose() {
    _selectedAssignmentBeans.dispose();
    super.dispose();
  }

  List<AssignmentBean> _getAssignmentsForDay(DateTime day) {
    return getAssignmentsByDay(day);
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
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getAssignmentsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              outsideDaysVisible: true,
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
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<AssignmentBean>>(
              valueListenable: _selectedAssignmentBeans,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    final DateFormat formatTime = DateFormat('HH:mm');
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () => print('${value[index]}'),
                        title: Text('${value[index].procedureName} '
                            '${formatTime.format(value[index].begin)}-'
                            '${formatTime.format(value[index].end)}'),
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
