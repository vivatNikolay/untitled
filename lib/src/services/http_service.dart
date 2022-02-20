import 'dart:convert';
import 'package:http/http.dart';
import 'package:untitled/src/models/sanatorium.dart';
import '../models/assignment.dart';
import '../models/relaxer.dart';

class HttpService {
  final String url = "https://admin:admin@api.byport.by/";
  final Map sanMap = Sanatorium.sanatoriumMap;

  Future<Relaxer> fetchRelaxer(String sanKey, String email) async {
    String postfix = sanKey + "/individual/";
    Response res = await get(Uri.parse(url+postfix+email+"/"));
    if (res.statusCode == 200) {
      return Relaxer.fromJson(jsonDecode(res.body));
    } else {
      throw "Unable to retrieve relaxer.";
    }
  }

  Future<List<Assignment>> fetchAssignments(String sanKey, String email) async {
    List<Assignment> myModels;
    String postfix = sanKey + "/individual/";
    Response res = await get(Uri.parse(url+postfix+email+"/assignments"));
    if (res.statusCode == 200) {
      return (jsonDecode(res.body) as List).map((i) =>
          Assignment.fromJson(i)).toList();
    } else {
      throw "Unable to retrieve assignments.";
    }
  }


}