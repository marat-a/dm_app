import 'dart:convert';

import 'package:http/http.dart' as http;

import '../http_client.dart';
import '../model/order.dart';

class OrderRepository {
  static const baseUrl = 'http://localhost:8080';



  Future<List<Order>> getAllOrders() async {
    final response = await HttpClient.get('/orders');

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      return responseData.map((json) => Order.fromJson(json)).toList();
    } else {
      throw Exception('Не удалось загрузить список заказов');
    }
  }

  Future<Order> getOrderById(int id) async {
    final response = await HttpClient.get('/orders/$id');

    if (response.statusCode == 200) {
      final dynamic responseData = jsonDecode(response.body);
      return Order.fromJson(responseData);
    } else {
      throw Exception('Не удалось получить заказ');
    }
  }

  Future<Order> createOrder(Order order) async {
    final response = await HttpClient.post('/orders',
      body: order,
    );

    if (response.statusCode == 200) {
      final dynamic responseData = jsonDecode(response.body);
      return Order.fromJson(responseData);
    } else {
      throw Exception('Не удалось создать заказ');
    }
  }

  Future<Order> updateOrder(int id, Order order) async {
    final response = await HttpClient.post('/orders/$id',
        body: {'data': jsonEncode(order.toJson())},
    );

    if (response.statusCode == 200) {
      final dynamic responseData = jsonDecode(response.body);
      return Order.fromJson(responseData);
    } else {
      throw Exception('Не удалось обновить заказ');
    }
  }

  Future<void> deleteOrder(int id) async {
    final response = await HttpClient.delete('/orders/$id');

    if (response.statusCode != 200) {
      throw Exception('Не удалось удалить заказ');
    }
  }
}