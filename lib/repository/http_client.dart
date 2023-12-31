import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HttpClient {
  static const String baseUrl = "http://localhost:8080";
  static const String tokenHeader = 'Authorization';


  static Future<http.Response> get(String path, {String? token}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final url = Uri.parse('$baseUrl$path');
    final headers = <String, String>{};

    if (token != null) {
      headers[tokenHeader] = "Bearer $token";
    }
    headers["Access-Control-Allow-Origin"] = "*";
    headers["Access-Control-Allow-Credentials"] = "true";
    headers["Content-Type"] = "application/json";
    headers["Accept"] = "*/*";

    return await http.get(url, headers: headers);
  }

  static Future<http.Response> post(String path, {String? token, Object? body}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('token');
    final url = Uri.parse('$baseUrl$path');
    final headers = <String, String>{};
    if (authToken != null) {
      headers[tokenHeader] = "Bearer $authToken";
    }
    headers["Access-Control-Allow-Origin"] = "*";
    headers["Access-Control-Allow-Credentials"] = "true";
    headers["Content-Type"] = "application/json";
    headers["Access-Control-Allow-Methods"] = "*";
    headers["Access-Control-Allow-Headers"] = "*";
    headers["Accept"] = "*/*";

    return await http.post(url, headers: headers, body: jsonEncode(body));
  }
  static Future<http.Response> put(String path, {String? token, Object? body}) async {
    final url = Uri.parse('$baseUrl$path');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('token');
    final headers = <String, String>{};
    if (authToken != null) {
      headers[tokenHeader] = 'Bearer $authToken';
    }
    headers["Access-Control-Allow-Origin"] = "*";
    headers["Access-Control-Allow-Credentials"] = "true";
    headers["Content-Type"] = "application/json";
    headers["Access-Control-Allow-Methods"] = "*";
    headers["Access-Control-Allow-Headers"] = "*";
    headers["Accept"] = "*/*";

    return await http.put(url, headers: headers, body: jsonEncode(body));
  }

  static Future<http.Response> delete(String path, {String? token}) async {
    final url = Uri.parse('$baseUrl$path');
    final headers = <String, String>{};
    if (token != null) {
      headers[tokenHeader] = 'Bearer $token';
    }
    headers["Access-Control-Allow-Origin"] = "*";
    headers["Access-Control-Allow-Credentials"] = "true";
    headers["Content-Type"] = "application/json";
    headers["Access-Control-Allow-Methods"] = "*";
    headers["Access-Control-Allow-Headers"] = "*";
    headers["Accept"] = "*/*";

    return await http.delete(url, headers: headers);
  }

}