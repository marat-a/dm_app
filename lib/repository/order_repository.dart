import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/order.dart';

class OrderRepository {
  static const baseUrl = 'https://92.118.113.20';

  Future<List<Order>> getAllOrders() async {
    final response = await http.get(Uri.parse('$baseUrl/orders'));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      return responseData.map((json) => Order.fromJson(json)).toList();
    } else {
      throw Exception('Не удалось загрузить список заказов');
    }
  }

  Future<Order> getOrderById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/orders/$id'));

    if (response.statusCode == 200) {
      final dynamic responseData = jsonDecode(response.body);
      return Order.fromJson(responseData);
    } else {
      throw Exception('Не удалось получить заказ');
    }
  }

  Future<Order> createOrder(Order order) async {
    final response = await http.post(
      Uri.parse('$baseUrl/orders'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(order.toJson()),
    );

    if (response.statusCode == 200) {
      final dynamic responseData = jsonDecode(response.body);
      return Order.fromJson(responseData);
    } else {
      throw Exception('Не удалось создать заказ');
    }
  }

  Future<Order> updateOrder(int id, Order order) async {
    final response = await http.put(
      Uri.parse('$baseUrl/orders/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(order.toJson()),
    );

    if (response.statusCode == 200) {
      final dynamic responseData = jsonDecode(response.body);
      return Order.fromJson(responseData);
    } else {
      throw Exception('Не удалось обновить заказ');
    }
  }

  Future<void> deleteOrder(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/orders/$id'));

    if (response.statusCode != 200) {
      throw Exception('Не удалось удалить заказ');
    }
  }
}