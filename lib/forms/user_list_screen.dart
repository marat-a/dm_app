import 'package:dm_app/forms/user_create_form.dart';
import 'package:dm_app/forms/user_detail_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import '../model/user.dart';
import '../repository/http_client.dart';

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

  void _navigateToUserDetailScreen(User user) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserDetailsScreen(user: user)),
    );
      _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список пользователей'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserCreateScreen(),
                ),
              ).then((result) {
                if (result != null && result is bool && result) {
                  _loadUsers();
                }
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return ListTile(
            title: Text(user.name ?? ''),
            subtitle: Text(user.phone ?? ''),
            onTap: () => _navigateToUserDetailScreen(user),
          );
        },
      ),
    );
  }
}