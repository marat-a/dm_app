

import 'package:dm_app/forms/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/http_client.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String errorMessage = '';


  void _navigateToHomeScreen(List<String> roles) {

    final MaterialPageRoute route = MaterialPageRoute(builder: (context) => HomeScreen(roles: roles));
    Navigator.pushReplacement(context, route);
  }


  Future<void> _login() async {
    final String login = loginController.text.trim();
    final String password = passwordController.text.trim();
    final response = await HttpClient.post(('/auth/login'),
      body: {
        'login': login,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final token = jsonDecode(response.body)['token'];
      final List<dynamic> rolesJson = jsonDecode(response.body)['roles'];
      final List<String> roles = rolesJson.map((role) => role.toString()).toList();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setStringList('roles', roles);
      _navigateToHomeScreen(roles);
    } else {
      setState(() {
        errorMessage = 'Неправильный логин или пароль';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Авторизация'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: loginController,
              decoration: const InputDecoration(
                labelText: 'Login',
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Пароль',
              ),
            ),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Войти'),
            ),
            Text(
              errorMessage,
              style: const TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
