// ignore_for_file: avoid_print

import 'dart:ffi';

import 'package:postgres/postgres.dart';

class DatabaseHelper{
  var connection = PostgreSQLConnection("localhost", 5432, "app", username: "postgres", password: "postgres"); // Mudar dps

  Future<void> openDB()async{
    await connection.open().then((value) => print('Conectado! :D'));
  }
  Future<dynamic> loginHotel(int cod, int pin)async{
    var s = await connection.mappedResultsQuery('''
    select * from hotel where codh =$cod and pin = $pin ;
    ''');
    return s;
  }
  Future<List<Map<String, Map<String, dynamic>>>> nomeHotelCod(int cod) async{
    var nome = await connection.mappedResultsQuery('''
    select nome from hotel where codh = $cod;
    ''');
    return nome;
  }

  Future<List<Map<String, Map<String, dynamic>>>> quartosHotel(int cod) async{
    var qts = await connection.mappedResultsQuery('''
    select q.numquarto, q.tipo, q.preco, a.andar from quartohotel q join quartos a on a.num = q.numquarto where q.codhotel = $cod;
    ''');
    return qts;
  }

}