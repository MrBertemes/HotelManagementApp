// ignore_for_file: avoid_print

import 'package:postgres/postgres.dart';

class DatabaseHelper{
  var connection = PostgreSQLConnection("localhost", 5432, "app", username: "postgres", password: "postgres"); // Mudar dps

  Future<void> openDB()async{
    await connection.open().then((value) => print('Conectado! :D'));
  }

}