import 'package:flutter/material.dart';
import 'views/RegisterUserView.dart';
import 'views/dashboard.dart' as dashboard_view;
import 'views/loginViews.dart' hide DashboardView;

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
        '/login': (context) => const LoginView(),
        '/dashboard': (context) => const dashboard_view.DashboardView(),
      }, 
    );
  }
}


