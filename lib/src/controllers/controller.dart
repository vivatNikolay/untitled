import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:untitled/src/controllers/response_state.dart';
import 'package:untitled/src/models/assignment.dart';
import 'package:untitled/src/services/assignment_service.dart';
import 'package:untitled/src/services/http_service.dart';
import '../models/relaxer.dart';
import '../services/relaxer_service.dart';

class HttpController {

  final HttpService _httpService = HttpService();
  final AssignmentService _assignmentService = AssignmentService();
  final RelaxerService _relaxerService = RelaxerService();

  late Relaxer _relaxer;
  late List<Assignment> _assignments;

  late Future<Relaxer> futureRelaxer;
  late Future<List<Assignment>> futureAssignment;

  ResponseState _stateRelaxer = ResponseState.processing;
  ResponseState _stateAssignment = ResponseState.processing;

  HttpController._privateConstructor();
  static final HttpController _instance = HttpController._privateConstructor();

  static HttpController get instance => _instance;

  void fetchData(String sanKey, String email) {
    fetchRelaxer(sanKey, email);
    fetchAssignments(sanKey, email);
    log('$sanKey $email');
  }

  void fetchRelaxer(String sanKey, String email) async {
    _stateRelaxer = ResponseState.processing;
    futureRelaxer = _httpService.fetchRelaxer(sanKey, email);
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
    futureAssignment = _httpService.fetchAssignments(sanKey, email);
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
    _assignmentService.delete();
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
    _relaxerService.delete();
    _assignmentService.delete();
  }

  Relaxer getActiveRelaxer() {
   return _relaxerService.getActive();
  }

  void makeInActive() {
    _relaxerService.makeInActive();
  }

  List<Relaxer> getRelaxers() {
    return _relaxerService.getRelaxers();
  }

  bool hasActive() {
    return _relaxerService.hasActive();
  }

  void makeActive(Relaxer relaxer) {
    _relaxerService.makeActive(relaxer);
  }

  List<Assignment> getAssignments() {
    return _assignmentService.getAssignments();
  }
}