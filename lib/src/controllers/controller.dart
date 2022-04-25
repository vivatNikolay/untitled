import 'dart:async';
import 'dart:developer';
import 'dart:io';
import '../models/assignment.dart';
import '../services/db/assignment_db_service.dart';
import '../services/http/assignment_http_service.dart';
import '../services/http/relaxer_http_service.dart';
import '../helpers/enums.dart';
import '../models/relaxer.dart';
import '../services/db/relaxer_db_service.dart';

class Controller {

  final AssignmentHttpService _assignmentHttpService = AssignmentHttpService();
  final RelaxerHttpService _relaxerHttpService = RelaxerHttpService();
  final AssignmentDBService _assignmentService = AssignmentDBService();
  final RelaxerDBService _relaxerService = RelaxerDBService();

  late Relaxer _relaxer;
  late List<Assignment> _assignments;

  late Future<Relaxer> futureRelaxer;
  late Future<List<Assignment>> futureAssignment;

  ResponseState _stateRelaxer = ResponseState.processing;
  ResponseState _stateAssignment = ResponseState.processing;

  Controller._privateConstructor();
  static final Controller _instance = Controller._privateConstructor();

  static Controller get instance => _instance;

  void fetchData(String sanKey, String email) {
    fetchRelaxer(sanKey, email);
    fetchAssignments(sanKey, email);
    log('$sanKey $email');
  }

  void fetchRelaxer(String sanKey, String email) async {
    _stateRelaxer = ResponseState.processing;
    futureRelaxer = _relaxerHttpService.fetch(sanKey, email);
    Timer(const Duration(milliseconds: 10), () {
      futureRelaxer.then((value) {
        _relaxer = value;
        _stateRelaxer = ResponseState.success;
      },
          onError: (e) {
            if (e is SocketException) {
              _stateRelaxer = ResponseState.no_connection;
            } else {
              _stateRelaxer = ResponseState.failed;
              log('fetch relaxer', error: e);
            }
          });
    });
  }

  void fetchAssignments(String sanKey, String email) async {
    _stateAssignment = ResponseState.processing;
    futureAssignment = _assignmentHttpService.fetch(sanKey, email);
    Timer(const Duration(milliseconds: 10), () {
      futureAssignment.then((value) {
        _assignments = value;
        _stateAssignment = ResponseState.success;
      },
          onError: (e) {
            if (e is SocketException) {
              _stateAssignment = ResponseState.no_connection;
            } else {
              _stateAssignment = ResponseState.failed;
              log('fetch assignments', error: e);
            }
          });
    });
  }

  void updateAssignments() {
    _assignmentService.deleteAll();
    _assignmentService.addAll(_assignments);
  }

  ResponseState getStateLogin() {
    return _stateRelaxer;
  }

  ResponseState getStateUpdate() {
    return _stateAssignment;
  }

  void writeToDB() {
    _relaxerService.add(_relaxer);
    _assignmentService.addAll(_assignments);
  }

  void exitFromAccount() {
    _relaxerService.delete(getActiveRelaxer());
    _assignmentService.deleteAll();
  }

  Relaxer getActiveRelaxer() {
   return _relaxerService.getActive();
  }

  void makeInActive() {
    _relaxerService.makeInActive();
  }

  List<Relaxer> getRelaxers() {
    return _relaxerService.getAll();
  }

  bool hasActive() {
    return _relaxerService.hasActive();
  }

  void makeActive(Relaxer relaxer) {
    _relaxerService.makeActive(relaxer);
  }

  List<Assignment> getAssignments() {
    return _assignmentService.getAll();
  }

  void deleteAssignments() {
    _assignmentService.deleteAll();
  }
}