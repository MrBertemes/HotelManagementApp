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
  Future<List<Map<String,Map<String,dynamic>>>> cadastroHotel(int cod, int pin, String nome, String end, String tel) async {
    var s = await connection.mappedResultsQuery('''
    insert into hotel values($cod, $pin, '$nome', '$end', '$tel');
    ''');
    return s;
  }

  Future<List<Map<String, Map<String, dynamic>>>> precoTipoQuartos(int cod) async{
    var qts = await connection.mappedResultsQuery('''
    select numquarto, preco, tipo from quartohotel where codhotel = $cod order by numquarto;
    ''');
    return qts;

  }

  Future<List<Map<String, Map<String, dynamic>>>> quartoDisponivel(int num, int codh) async {
    DateTime data = DateTime.now();
    print(data);
    var res = await connection.mappedResultsQuery('''
    select esta_disponivel($num, $codh, '$data');
    ''');
    return res;
  }
}