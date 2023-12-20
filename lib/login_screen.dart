import 'package:dm_app/forms/order_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String errorMessage = '';


  void _navigateToOrdersScreen() {
    final MaterialPageRoute route = MaterialPageRoute(builder: (context) => const OrderListScreen());
    Navigator.pushReplacement(context, route);
  }


  Future<void> _login() async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    // Отправка POST-запроса на ваше API
    final response = await http.post(
      Uri.parse('https://92.118.113.20/login'),
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final token = jsonDecode(response.body)['token'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      _navigateToOrdersScreen();
    } else {
      setState(() {
        errorMessage = 'Неправильный email или пароль';
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
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
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
