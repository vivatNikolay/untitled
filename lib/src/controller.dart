import 'dart:async';
import 'dart:developer';
import 'package:untitled/boxes.dart';
import 'package:untitled/src/models/assignment.dart';
import 'package:untitled/src/services/http_service.dart';
import 'models/relaxer.dart';

class HttpController {

  final boxRelaxer = Boxes.getRelaxer();
  final boxAssignments = Boxes.getAssignment();
  late Future<Relaxer> futureRelaxer;
  late Future<List<Assignment>> futureAssignment;
  final HttpService _httpService = HttpService();
  bool _success = false;

  HttpController._privateConstructor();
  static final HttpController _instance = HttpController._privateConstructor();

  static HttpController get instance => _instance;

  void init(String sanKey, String email) async {
    futureRelaxer = _httpService.fetchRelaxer(sanKey, email);
    futureAssignment = _httpService.fetchAssignments(sanKey, email);
    log(sanKey+" "+email);
    Timer(const Duration(milliseconds: 10), () {
      futureRelaxer.then((value) {
        _success = true;
        setRelaxer(value);
        },
          onError: (e) {
            _success = false;
          });
      futureAssignment.then((value) {
        setAssignments(value);
      },
          onError: (e) {
            log('ERROR', error: e);
          });
    });
  }

  bool isSuccess() {
    return _success;
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