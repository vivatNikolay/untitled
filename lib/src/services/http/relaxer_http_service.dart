import 'dart:convert';
import 'package:untitled/src/services/http/http_service.dart';
import 'package:http/http.dart';
import 'package:untitled/src/models/relaxer.dart';

class RelaxerHttpService extends HttpService<Relaxer>{

  @override
  Future<Relaxer> fetch(String sanKey, String email) async {
    Response res = await get(Uri.parse(url+sanKey+postfix+email+"/"),
        headers: <String, String>{"authorization" : basicAuth()});
    if (res.statusCode == 200) {
      Relaxer relaxer = Relaxer.fromJson(jsonDecode(res.body));
      relaxer.sanatorium = sanKey;
      return relaxer;
    } else {
      throw "Unable to retrieve relaxer.";
    }
  }
}