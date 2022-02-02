import 'dart:async';
import 'dart:developer';
import 'package:untitled/boxes.dart';
import 'package:untitled/src/services/http_service.dart';
import 'models/relaxer.dart';

class HttpController {

  final box = Boxes.getRelaxer();
  late Future<Relaxer> futureRelaxer;
  final HttpService _httpService = HttpService();

  HttpController._privateConstructor();
  static final HttpController _instance = HttpController._privateConstructor();

  static HttpController get instance => _instance;

  void init(String sanKey, String phone) async {
    futureRelaxer = _httpService.fetchRelaxer(sanKey, phone);
    log(sanKey+" "+phone);
    Timer(const Duration(milliseconds: 100), () {
      futureRelaxer.then((value) { setRelaxer(value); },
          onError: (e) {
        log("relaxer not init!!!");
          });
    });
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