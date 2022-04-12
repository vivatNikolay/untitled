import 'dart:convert';
import 'package:http/http.dart';
import '../models/assignment.dart';
import '../models/relaxer.dart';

class HttpService {
  final String _user = "admin";
  final String _pass = "byport";
  final String _url = "https://api.byport.by/";
  final String _postfix = "/mobile/";

  Future<Relaxer> fetchRelaxer(String sanKey, String email) async {
    Response res = await get(Uri.parse(_url+sanKey+_postfix+email+"/"),
        headers: <String, String>{"authorization" : _basicAuth()});
    if (res.statusCode == 200) {
      Relaxer relaxer = Relaxer.fromJson(jsonDecode(res.body));
      relaxer.sanatorium = sanKey;
      return relaxer;
    } else {
      throw "Unable to retrieve relaxer.";
    }
  }

  Future<List<Assignment>> fetchAssignments(String sanKey, String email) async {
    Response res = await get(Uri.parse(_url+sanKey+_postfix+email+"/assignments"),
        headers: <String, String>{"authorization" : _basicAuth()});
    if (res.statusCode == 200) {
      return (jsonDecode(res.body) as List).map((i) =>
          Assignment.fromJson(i)).toList();
    } else {
      throw "Unable to retrieve assignments.";
    }
  }

  String _basicAuth() {
    return 'Basic ' + base64Encode(utf8.encode("$_user:$_pass"));
  }


}