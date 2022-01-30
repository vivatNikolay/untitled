import 'dart:convert';
import 'package:http/http.dart';
import 'package:untitled/src/models/sanatorium.dart';
import '../models/relaxer.dart';

class HttpService {
  final String url = "https://admin:admin@api.byport.by/";
  final Map sanMap = Sanatorium.sanatoriumMap;

  Future<Relaxer> fetchRelaxer(String sanKey, String phone) async {
    String postfix = sanKey + "/individual/";
    Response res = await get(Uri.parse(url+postfix+phone));
    if (res.statusCode == 200) {
      return Relaxer.fromJson(jsonDecode(res.body));
    } else {
      throw "Unable to retrieve relaxer.";
    }
  }


}