import 'dart:convert';
import 'package:untitled/src/services/http/http_service.dart';
import 'package:http/http.dart';
import '../../models/assignment.dart';

class AssignmentHttpService extends HttpService<List<Assignment>> {

  @override
  Future<List<Assignment>> fetch(String sanKey, String email) async {
    Response res = await get(Uri.parse(url+sanKey+postfix+email+"/assignments"),
        headers: <String, String>{"authorization" : basicAuth()});
    if (res.statusCode == 200) {
      return (jsonDecode(res.body) as List).map((i) =>
          Assignment.fromJson(i)).toList();
    } else {
      throw "Unable to retrieve assignments.";
    }
  }
}