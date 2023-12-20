import 'package:dm_app/forms/order_list_screen.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/orders': (context) => const OrderListScreen(),
        // Добавьте маршруты для других экранов вашего приложения
      },
    );
  }
}
