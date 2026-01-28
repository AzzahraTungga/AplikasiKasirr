import 'package:flutter/material.dart';
import 'views/RegisterUserView.dart';
import 'views/loginViews.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const RegisterUserView(),
        '/login': (context) => const LoginView()
      }, 
    );
  }
}


