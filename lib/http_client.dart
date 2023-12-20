import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpClient {
  static const String baseUrl = 'https://92.118.113.20';
  static const String tokenHeader = 'Authorization';

  static Future<http.Response> get(String path, {String? token}) async {
    final url = Uri.parse('$baseUrl$path');
    final headers = <String, String>{};

    if (token != null) {
      headers[tokenHeader] = 'Bearer $token';
    }
    headers['Access-Control-Allow-Origin'] = '*';
    headers['Content-Type'] = 'application/json';
    headers['Accept'] = '*/*';

    return await http.get(url, headers: headers);
  }

  static Future<http.Response> post(String path, {String? token, Map<String, String>? body}) async {
    final url = Uri.parse('$baseUrl$path');
    final headers = <String, String>{};
    if (token != null) {
      headers[tokenHeader] = 'Bearer $token';
    }
    headers["Access-Control-Allow-Origin"] = '*';
    headers['Content-Type'] = 'application/json';
    headers['Accept'] = '*/*';
    return await http.post(url, headers: headers, body: jsonEncode(body));
  }

// Добавьте другие методы для других типов запросов (например, PUT, DELETE и т.д.)
}