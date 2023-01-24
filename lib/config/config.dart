import 'dart:convert';

import 'package:http/http.dart' as http;

class Config {
  final String _url = 'http://10.0.2.2:8000/api/';

  //POST login
  postApi(apiUrl, data) async {
    var fullUrl = _url + apiUrl;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  getApi(apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.get(Uri.parse(fullUrl), headers: _setHeaders());
  }

//Default Header
  _setHeaders() => {
        'Content-type': 'application/json;charset=UTF-8',
        'Accept': 'application/json',
        'Charset': 'utf-8',
      };
}