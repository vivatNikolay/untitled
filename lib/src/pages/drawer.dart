import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../controllers/controller.dart';
import '../helpers/constants.dart';
import '../models/relaxer.dart';
import 'list_relaxers.dart';
import 'login/login.dart';
import 'tab_manager.dart';

class MyDrawer extends StatelessWidget {

  late Relaxer relaxer;

  final Controller _httpController = Controller.instance;
  final TabManager _tabManager = TabManager.instance;

  MyDrawer({Key? key}) : super(key: key) {
    relaxer = _httpController.getActiveRelaxer();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [shadowColor, primaryColor])),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 40.0,
                        child: Image.asset(relaxer.sex ? manImage : womanImage),
                      ),
                    ),
                    Align(
                        alignment:
                        Alignment.bottomLeft + const Alignment(-0.05, -0.45),
                        child: Text(
                          '${relaxer.name} ${relaxer.surname}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontFamily: 'TimesNewRoman'),
                        )),
                    Align(
                        alignment:
                        Alignment.bottomLeft + const Alignment(-0.02, -0.05),
                        child: Text(
                          relaxer.email,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 17.0,
                              fontFamily: 'TimesNewRoman'),
                        ))
                  ],
                )),
            ListTile(
              leading: const Icon(Icons.person_add),
              minLeadingWidth: 24,
              title: const Text('???????????????? ??????????????'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()
                    ));
                _httpController.deleteAssignments();
                _httpController.makeInActive();
                _tabManager.cancelNotifications();
              },
            ),
            ListTile(
              leading: const Icon(Icons.group),
              minLeadingWidth: 24,
              title: const Text('?????????????? ??????????????'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const ListRelaxers()
                    ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              minLeadingWidth: 24,
              title: const Text('?????????? ???? ????????????????'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()
                    ));
                _httpController.exitFromAccount();
                _tabManager.cancelNotifications();
              },
            )
          ],
        ));
  }
}
