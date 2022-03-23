import 'package:flutter/material.dart';
import 'package:untitled/src/pages/drawer.dart';
import 'package:untitled/src/pages/tabs/list_for_day.dart';
import 'tabs/calendar.dart';

class MyHomePage extends StatefulWidget {
  final String title = 'Расписание';

  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late DateTime _today;
  late DateTime _tomorrow;
  late ValueNotifier<bool> buttonClicked;

  @override
  void initState() {
    super.initState();

    _today = DateTime.now();
    _tomorrow = DateTime(_today.year, _today.month, _today.day + 1);
    buttonClicked = ValueNotifier(false);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: IconButton(
                  onPressed: () {
                    if(buttonClicked.value) {
                      buttonClicked.value = false;
                  } else {
                      buttonClicked.value = true;
                    }
                  },
                  icon: const Icon(Icons.update),
                )
            ),
          ],
          bottom: const TabBar(tabs: [
            Tab(text: 'Сегодня'),
            Tab(text: 'Завтра'),
            Tab(icon: Icon(Icons.calendar_today_rounded)),
          ], indicatorColor: Colors.blueGrey),
        ),
        body: Center(
            child: TabBarView(children: [
              ListForDay(_today, buttonClicked),
              ListForDay(_tomorrow, buttonClicked),
              TableAssignments(buttonClicked)
        ])),
        drawer: MyDrawer(),
      ),
    );
  }
}
