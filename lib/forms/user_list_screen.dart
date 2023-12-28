

import 'package:dm_app/forms/user_detail_screen.dart';
import 'package:dm_app/forms/user_edit_form.dart';
import 'package:dm_app/forms/user_form.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/user.dart';
import '../repository/http_client.dart';
import 'user_edit_form.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  UserListScreenState createState() => UserListScreenState();
}

class UserListScreenState extends State<UserListScreen> {
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    try {
      final response = await HttpClient.get('/users');
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        setState(() {
          _users = List<User>.from(jsonData.map((user) => User.fromJson(user)));
        });
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void _navigateToUserEdit(User user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserDetailsScreen(user: user)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список пользователей'),
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return ListTile(
            title: Text(user.name ?? ''),
            subtitle: Text(user.phone ?? ''),
            onTap: () => _navigateToUserEdit(user),
          );
        },
      ),
    );
  }
}