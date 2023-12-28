import 'package:flutter/material.dart';
import 'package:dm_app/forms/user_list_screen.dart';
import 'package:dm_app/forms/order_list_screen.dart';
import 'package:dm_app/enums/erole.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<String> roles;

  const HomeScreen({super.key, required this.roles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DeliveryManager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              _logout(context);
            },
          ),
        ],
      ),
      body: _buildBody(),
    );
  }
  void _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
  Widget _buildBody() {
    if (roles.any((role) => role == ERole.ADMIN.name)) {
      return const UserListScreen();
    } else if (roles.any(
            (role) => role == ERole.MANAGER.name || role == ERole.COURIER.name)) {
      return const OrderListScreen();
    } else {
      return const Center(
        child: Text('Роль не найдена'),
      );
    }
  }
}