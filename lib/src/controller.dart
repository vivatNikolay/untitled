import 'dart:async';
import 'dart:developer';
import 'package:untitled/boxes.dart';
import 'package:untitled/src/services/http_service.dart';
import 'models/relaxer.dart';

class HttpController {

  final box = Boxes.getRelaxer();
  late Future<Relaxer> futureRelaxer;
  final HttpService _httpService = HttpService();
  bool _success = false;

  HttpController._privateConstructor();
  static final HttpController _instance = HttpController._privateConstructor();

  static HttpController get instance => _instance;

  void init(String sanKey, String email) async {
    futureRelaxer = _httpService.fetchRelaxer(sanKey, email);
    log(sanKey+" "+email);
    Timer(const Duration(milliseconds: 10), () {
      futureRelaxer.then((value) {
        _success = true;
        setRelaxer(value);
        },
          onError: (e) {
            _success = false;
          });
    });
  }

  bool isSuccess() {
    return _success;
  }

  void setRelaxer(Relaxer relaxer) {
    box.put(0, relaxer);
  }

  Relaxer? getRelaxer() {
    return box.get(0);
  }

  void deleteRelaxer() {
    box.get(0)!.delete();
  }
}