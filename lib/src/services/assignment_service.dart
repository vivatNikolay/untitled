import '../../boxes.dart';
import '../models/assignment.dart';

class AssignmentService {

  final boxAssignments = Boxes.getAssignments();

  void addAll(Iterable<Assignment> assignments) {
    boxAssignments.addAll(assignments);
  }

  void delete() {
    boxAssignments.clear();
  }

  List<Assignment> getAssignments() {
    return boxAssignments.values.toList();
  }
}