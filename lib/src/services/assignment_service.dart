import '../../boxes.dart';
import '../models/assignment.dart';

class AssignmentService {

  final boxAssignments = Boxes.getAssignments();

  void addAll(Iterable<Assignment> assignments) {
    boxAssignments.addAll(assignments);
  }

  void delete() {
    boxAssignments.deleteAll(boxAssignments.keys);
  }

  List<Assignment> getAssignments() {
    return boxAssignments.values.toList();
  }
}