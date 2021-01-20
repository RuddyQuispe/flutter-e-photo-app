import 'dart:convert';

import 'package:http/http.dart' as http;

class HTTP {
  String _url =
      'http://ec2-54-232-175-236.sa-east-1.compute.amazonaws.com:5000';

  Future<Map> get(String route) async {
    route = "$_url$route";
    var response = await http.get(route);
    print(response);
    var data = jsonDecode(response.body);
    return data;
  }

  Future<Map> post(String route, dynamic data) async {
    route = "$_url$route";
    http.Response response = await http.post(
      route,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    Map res = json.decode(response.body);
    print(res["data"]);
    return res;
  }
}
