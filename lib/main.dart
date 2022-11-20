// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables

import 'package:bk/pages/chambre.dart';
import 'package:bk/pages/hotel.dart';
import 'package:bk/pages/signup.dart';
import 'package:flutter/material.dart';
import './pages/splash.dart';
import './pages/login.dart';

String _defaultHome = '/login';
var hotel;
late var nomeHotel;
late var enderecoHotel;
late var numHotel;
late int codHotel;
late var telefoneHotel;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      home: Main(),
    ),
  );
}

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
        '/signup': (context) => const SignupPage(),
        '/hotel': (context) => const HotelPage(),
        '/chambre': (context) => const ChambrePage(),
      },
    );
  }
}
