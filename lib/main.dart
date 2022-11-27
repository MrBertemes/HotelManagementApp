// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables

import 'package:bk/pages/chambre.dart';
import 'package:bk/pages/estadia.dart';
import 'package:bk/pages/hotel.dart';
import 'package:bk/pages/reservation.dart';
import 'package:bk/pages/signup.dart';
import 'package:bk/services/db.dart';
import 'package:bk/services/reserv.dart';
import 'package:flutter/material.dart';
import './pages/splash.dart';
import './pages/login.dart';

String _defaultHome = '/login';
DatabaseHelper db = DatabaseHelper();
late List<Map<String,Map<String,dynamic>>> hotel;
late String nomeHotel;
late String enderecoHotel;
late String numHotel;
late int codHotel;
late int qtAndarHotel;
late int iGlobal;
late int jGlobal;
List<List<double>> matrixPreco = [];
List<List<int>> matrixNum = [];
List<List<String>> matrixTipo = [];
List<List<int>> matrixDisponivel = [];
List<Reserv> listReserv = [];
late List<Map<String,Map<String,dynamic>>> quartosHotel ;
late String telefoneHotel;

void main() async {

  for (var i = 0; i < 10; i++) {
    List<int> listNum = <int>[];
    List<double> listPreco = <double>[];
    List<String> listTipo = <String>[];
    List<int> listDisp = <int>[];
    for (var j = 0; j < 10; j++) {
      listPreco.add(0.0);
      listTipo.add('');
      listNum.add(0);
      listDisp.add(0);
    }
    matrixPreco.add(listPreco);
    matrixTipo.add(listTipo);
    matrixNum.add(listNum);
    matrixDisponivel.add(listDisp);
  }
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
        '/reserva':(context) => const ReservaPage(),
        '/estadia':(context) => const EstadiaPage(),
      },
    );
  }
}
