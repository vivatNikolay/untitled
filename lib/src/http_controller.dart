import 'dart:async';
import 'dart:developer';

import 'package:untitled/src/services/http_service.dart';

import 'models/relaxer.dart';

class HttpController {

  late Future<Relaxer> futureRelaxer;
  late Relaxer relaxer;
  final HttpService _httpService = HttpService();

  HttpController._privateConstructor();

  static final HttpController _instance = HttpController._privateConstructor();

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
    this.relaxer = relaxer;
  }

  Relaxer getRelaxer() {
    return relaxer;
  }

  static HttpController get instance => _instance;

  void handleError(e) {
    log(e);
  }

}