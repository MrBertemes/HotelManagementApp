import 'package:postgres/postgres.dart';

class DatabaseHelper{
  var connection = PostgreSQLConnection("localhost", 5432, "app", username: "postgres", password: "postgres"); // Mudar dps

  Future<void> openDB()async{
    await connection.open().then((value) => print('Conectado! :D'));
  }
  Future<List<Map<String,Map<String,dynamic>>>> loginHotel(int cod, int pin)async{
    var hotel = await connection.mappedResultsQuery('''
    select * from hotel where codh =$cod and pin = $pin ;
    ''');
    return hotel;
  }
  Future<List<Map<String,Map<String,dynamic>>>> verificaSenhaErrada(int cod, int pin) async{
    var existe  = await connection.mappedResultsQuery('''
    select count(codh) from hotel where codh = $cod and pin <> $pin; 
    ''');
    return existe;
  }
  Future<PostgreSQLResult> cadastroHotel(int cod, int pin, String nome, String end, String tel) async {
    var s = await connection.query('''
    insert into hotel values($cod, $pin, $nome, $end, $tel);
    ''');
    return s;
  }

  Future<List<Map<String, Map<String, dynamic>>>> quartosHotel(int cod) async{
    var qts = await connection.mappedResultsQuery('''
    select q.numquarto, q.tipo, q.preco, a.andar from quartohotel q join quartos a on a.num = q.numquarto where q.codhotel = $cod;
    ''');
    return qts;
  }

}