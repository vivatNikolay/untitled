import 'dart:convert';
import 'package:http/http.dart';
import 'package:untitled/src/models/sanatorium.dart';
import '../models/assignment.dart';
import '../models/relaxer.dart';

class HttpService {
  final String _url = "https://admin:byport@api.byport.by/";
  final String _postfix = "/mobile/";
  final Map sanMap = Sanatorium.sanatoriumMap;

  Future<Relaxer> fetchRelaxer(String sanKey, String email) async {
    Response res = await get(Uri.parse(_url+sanKey+_postfix+email+"/"));
    if (res.statusCode == 200) {
      Relaxer relaxer = Relaxer.fromJson(jsonDecode(res.body));
      relaxer.sanatorium = sanKey;
      return relaxer;
    } else {
      throw "Unable to retrieve relaxer.";
    }
  }

  Future<List<Assignment>> fetchAssignments(String sanKey, String email) async {
    Response res = await get(Uri.parse(_url+sanKey+_postfix+email+"/assignments"));
    if (res.statusCode == 200) {
      return (jsonDecode(res.body) as List).map((i) =>
          Assignment.fromJson(i)).toList();
    } else {
      throw "Unable to retrieve assignments.";
    }
  }


}