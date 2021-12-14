import 'package:flutter/material.dart';
import 'package:untitled/src/utils.dart';
import 'calendar.dart';

class MyHomePage extends StatefulWidget {
  final String title = 'Schedule';
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: const TabBar(tabs: [
            Tab(text: 'Today'),
            Tab(text: 'Tomorrow'),
            Tab(icon: Icon(Icons.calendar_today_rounded)),
          ],),
        ),
        body: Center(
            child: TabBarView(children: [
              listView(kToday),
              listView(kTomorrow),
              const TableAssignments()
            ])
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFF4A148C), Colors.deepPurple])),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 40.0,
                          child: Image.asset(relaxer.gender
                              ? "assets/images/man.png"
                              : "assets/images/woman.png"),
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomLeft +
                              const Alignment(-0.05, -0.45),
                          child: Text(
                            '${relaxer.name} ${relaxer.surname}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontFamily: 'TimesNewRoman'),
                          )),
                      Align(
                          alignment: Alignment.bottomLeft +
                              const Alignment(-0.05, -0.05),
                          child: Text(
                            relaxer.phone,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17.0,
                                fontFamily: 'TimesNewRoman'),
                          )),
                      const Align(
                        alignment: Alignment.topRight,
                        child: Icon(
                          Icons.settings,
                          size: 26,
                          color: Colors.white,
                        ),
                      )
                    ],
                  )),
              ListTile(
                leading: const Icon(Icons.person_search),
                minLeadingWidth: 24,
                title: const Text('Change user'),
                onTap: () {
                  // Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                minLeadingWidth: 24,
                title: const Text('Setting'),
                onTap: () {
                  // Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView listView(DateTime day) {
    return ListView.builder(
        itemCount: getAssignmentsByDay(day).length,
        itemBuilder: (_, index) {
          return Card(
            shadowColor: Colors.deepPurple,
            elevation: 4.0,
            child: ListTile(
              title: Text(getAssignmentsByDay(day)[index].procedureName),
              subtitle: Text(
                  formatTime.format(getAssignmentsByDay(day)[index].begin)),
              trailing: const Icon(Icons.more_vert),
            ),
          );
        });
  }
}