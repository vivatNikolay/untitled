import 'package:hive/hive.dart';
import '../../models/assignment.dart';
import 'db_service.dart';

class AssignmentDBService extends DBService<Assignment> {

  final boxAssignments = Hive.box<Assignment>('assignment');

  @override
  void addAll(Iterable<Assignment> assignments) {
    boxAssignments.addAll(assignments);
  }

  @override
  void deleteAll() {
    boxAssignments.deleteAll(boxAssignments.keys);
  }

  @override
  List<Assignment> getAll() {
    return boxAssignments.values.toList();
  }

  @override
  void add(Assignment assignment) {
    boxAssignments.add(assignment);
  }

  @override
  void delete(Assignment assignment) {
    assignment.delete();
  }
}