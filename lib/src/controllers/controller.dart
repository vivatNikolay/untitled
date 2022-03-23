import 'dart:async';
import 'dart:developer';
import 'package:untitled/src/controllers/response_state.dart';
import 'package:untitled/src/models/assignment.dart';
import 'package:untitled/src/services/assignment_service.dart';
import 'package:untitled/src/services/http_service.dart';
import '../models/assignment_bean.dart';
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

  late ResponseState _state;

  HttpController._privateConstructor();
  static final HttpController _instance = HttpController._privateConstructor();

  static HttpController get instance => _instance;

  void fetchData(String sanKey, String email) {
    _state = ResponseState.processing;
    fetchRelaxer(sanKey, email);
    fetchAssignments(sanKey, email);
    log('$sanKey $email');
  }

  void fetchRelaxer(String sanKey, String email) async {
    futureRelaxer = _httpService.fetchRelaxer(sanKey, email);
    Timer(const Duration(milliseconds: 10), () {
      futureRelaxer.then((value) {
        _state = ResponseState.success;
        _relaxer = value;
      },
          onError: (e) {
            _state = ResponseState.failed;
            log('fetch relaxer', error: e);
          });
    });
  }

  void fetchAssignments(String sanKey, String email) async {
    futureAssignment = _httpService.fetchAssignments(sanKey, email);
    Timer(const Duration(milliseconds: 10), () {
      futureAssignment.then((value) {
        _assignments = value;
      },
          onError: (e) {
            _assignments = [];
            log('fetch assignments', error: e);
          });
    });
  }

  void updateAssignments() {
    _assignmentService.addAll(_assignments);
  }

  bool isSuccess() {
    return _state == ResponseState.success;
  }

  bool isProcessing() {
    return _state == ResponseState.processing;
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
    _assignmentService.delete();
  }

  List<AssignmentBean> getAssignmentsByDay(DateTime day) {
    return _assignmentService.getAssignmentsByDay(day);
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

  void deleteAssignments() {
    _assignmentService.delete();
  }
}