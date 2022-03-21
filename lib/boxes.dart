import 'package:hive/hive.dart';
import 'package:untitled/src/models/assignment.dart';
import 'package:untitled/src/models/relaxer.dart';

class Boxes {
  static Box<Relaxer> getRelaxers() =>
      Hive.box<Relaxer>('relaxer');

  static Box<Assignment> getAssignments() =>
      Hive.box<Assignment>('assignment');
}