import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:dm_app/model/Order.dart';

class OrderService {
  static const String apiUrl = 'http://92.118.113.20:8080/orders';

  static Future<List<Order>> fetchOrders() async {
    final response = await http.get(Uri.parse(apiUrl), headers: {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    })
      ;

    if (response.statusCode == HttpStatus.ok) {
      final List<dynamic> orderJsonList = json.decode(response.body);
      return orderJsonList.map((json) => Order.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch orders');
    }
  }
}
