import 'dart:async';
import 'dart:developer';
import 'package:untitled/boxes.dart';
import 'package:untitled/src/controllers/response_state.dart';
import 'package:untitled/src/models/assignment.dart';
import 'package:untitled/src/services/http_service.dart';
import '../models/relaxer.dart';

class HttpController {

  final HttpService _httpService = HttpService();
  final boxRelaxer = Boxes.getRelaxer();
  final boxAssignments = Boxes.getAssignment();

  late Relaxer _relaxer;
  late List<Assignment> _assignments;

  late Future<Relaxer> futureRelaxer;
  late Future<List<Assignment>> futureAssignment;

  late ResponseState _state;

  HttpController._privateConstructor();
  static final HttpController _instance = HttpController._privateConstructor();

  static HttpController get instance => _instance;

  void fetchData(String sanKey, String email) async {
    _state = ResponseState.processing;
    futureRelaxer = _httpService.fetchRelaxer(sanKey, email);
    futureAssignment = _httpService.fetchAssignments(sanKey, email);
    log(sanKey+" "+email);
    Timer(const Duration(milliseconds: 10), () {
      futureRelaxer.then((value) {
        _state = ResponseState.success;
        _relaxer = value;
        },
          onError: (e) {
            _state = ResponseState.failed;
            log('futureRelaxer', error: e);
          });
      futureAssignment.then((value) {
        _assignments = value;
      },
          onError: (e) {
            _state = ResponseState.failed;
            log('futureAssignment', error: e);
          });
    });
  }

  bool isSuccess() {
    return _state == ResponseState.success;
  }

  bool isProcessing() {
    return _state == ResponseState.processing;
  }

  void writeToDB() {
    setRelaxer(_relaxer);
    setAssignments(_assignments);
  }

  void setRelaxer(Relaxer relaxer) {
    boxRelaxer.put(0, relaxer);
  }

  Relaxer getRelaxer() {
    return boxRelaxer.get(0)
        ?? Relaxer(email: 'privet@gmail.com', name: 'Name', surname: 'Surname', sex: true);
  }

  void deleteRelaxer() {
    boxRelaxer.get(0)!.delete();
  }

  void setAssignments(Iterable<Assignment> assignments) {
    boxAssignments.addAll(assignments);
  }

  List<Assignment> getAssignments() {
    Iterable<Assignment> list = boxAssignments.values;
    return list.toList();
  }

  void deleteAssignments() {
    boxAssignments.clear();
  }
}