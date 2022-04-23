import 'dart:convert';

abstract class HttpService<T> {
  final String _user = "admin";
  final String _pass = "byport";
  final String url = "https://api.byport.by/";
  final String postfix = "/mobile/";

  Future<T> fetch(String sanKey, String email);

  String basicAuth() {
    return 'Basic ' + base64Encode(utf8.encode("$_user:$_pass"));
  }


}