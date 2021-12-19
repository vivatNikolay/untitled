import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/src/login.dart';

import 'entity.dart';

class MyDrawer extends StatelessWidget {

  final Relaxer relaxer;

  MyDrawer({ required this.relaxer});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                        Alignment.bottomLeft + const Alignment(-0.05, -0.05),
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
              leading: const Icon(Icons.logout),
              minLeadingWidth: 24,
              title: const Text('Log out'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => LoginScreen()
                    ));
              },
            ),
          ],
        ));
  }
}
