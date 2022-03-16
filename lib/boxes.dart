import 'package:hive/hive.dart';
import 'package:untitled/src/models/assignment.dart';
import 'package:untitled/src/models/relaxer.dart';

class Boxes {
  static Box<Relaxer> getRelaxer() =>
      Hive.box<Relaxer>('relaxer');

  static Box<Assignment> getAssignment() =>
      Hive.box<Assignment>('assignment');
}