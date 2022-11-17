// ignore_for_file: deprecated_member_use

import 'package:bk/pages/signup.dart';
import 'package:flutter/material.dart';
import './pages/splash.dart';
import './pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      home: Main(),
    ),
  );
}

String _defaultHome = '/login';

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.grey[900],
      ),
      routes: {
        '/': (context) => SplashScreen(route: _defaultHome),
        '/login': (context) => const LoginPage(),
        '/signup':(context) => const SignupPage(),
      },
    );
  }
}
