import 'package:dm_app/forms/order_list_screen.dart';
import 'package:dm_app/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkTokenValidity();
  }

  bool isTokenValid(String? token) {
    if (token == null) {
      return false;
    }

    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);
      DateTime expirationDate =
          DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);
      return expirationDate.isAfter(DateTime.now());
    } catch (e) {
      return false;
    }
  }

  void checkTokenValidity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Future.delayed(const Duration(seconds: 2), () {
      if (isTokenValid(token)) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OrderListScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Загрузка...'),
      ),
    );
  }
}
