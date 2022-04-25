import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest_10y.dart' as tz;
import 'src/controllers/controller.dart';
import 'src/helpers/constants.dart';
import 'src/models/assignment.dart';
import 'src/models/date_time_interval.dart';
import 'src/models/relaxer.dart';
import 'src/pages/login/login.dart';
import 'src/pages/home.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides ();

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(RelaxerAdapter());
  Hive.registerAdapter(AssignmentAdapter());
  Hive.registerAdapter(DateTimeIntervalAdapter());
  await Hive.openBox<Relaxer>('relaxer');
  await Hive.openBox<Assignment>('assignment');

  tz.initializeTimeZones();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Controller _httpController = Controller.instance;
    StatefulWidget home;
    if (_httpController.hasActive()) {
      home = const MyHomePage();
    } else {
      home = const LoginScreen();
    }
    return MaterialApp(
      title: 'Scheduler',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: primaryColor,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: home,
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}