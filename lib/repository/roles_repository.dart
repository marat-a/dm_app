import 'dart:convert';

import 'package:dm_app/enums/role.dart';

import 'http_client.dart';

class RolesRepository {
  static const baseUrl = 'http://localhost:8080';


  Future<List<Role>> getAllRoles() async {
    final response = await HttpClient.get('/roles');

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      return responseData.map((json) => Role.fromJson(json)).toList();
    } else {
      throw Exception('Не удалось загрузить список заказов');
    }
  }
}