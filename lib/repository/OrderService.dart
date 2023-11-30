import 'dart:convert';
import 'dart:io';

import 'package:dm_app/model/Order.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class OrderService {
  static const String apiUrl = 'https://92.118.113.20:8080/orders';

  static Future<List<Order>> fetchOrders() async {
    final response = await http.get(Uri.parse(apiUrl), headers: {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*'
    });

    if (response.statusCode == HttpStatus.ok) {
      final List<dynamic> orderJsonList = json.decode(response.body);
      return orderJsonList.map((json) => Order.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch orders');
    }
  }

  Future<bool> saveOrder(Order order) async {
    try {
      // Преобразуйте объект заказа в JSON-строку
      final orderJson = order.toJson();

      // Отправьте POST-запрос на сервер с JSON-строкой заказа
      final response = await http.post(Uri.parse(apiUrl),
          body: json.encode(orderJson),
          headers: {'Content-Type': 'application/json'});

      // Проверьте статус кода ответа
      if (response.statusCode == HttpStatus.created) {
        // Заказ сохранен успешно
        return true;
      } else {
        // При сохранении заказа произошла ошибка
        return false;
      }
    } catch (exception) {
      // Обработка исключения при сохранении заказа
      if (kDebugMode) {
        print('Failed to save order: $exception');
      }
      return false;
    }
  }
}
