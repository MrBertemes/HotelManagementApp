// ignore_for_file: non_constant_identifier_names

import 'package:bk/main.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:postgres/postgres.dart';

class DatabaseHelper {
  var connection = PostgreSQLConnection("localhost", 5432, "app",
      username: "postgres", password: "postgres"); // Mudar dps

  Future<void> openDB() async {
    await connection.open().then((value) => print('Conectado! :D'));
  }

  Future<List<Map<String, Map<String, dynamic>>>> loginHotel(
      int cod, int pin) async {
    var hotel = await connection.mappedResultsQuery('''
    select * from hotel where codh =$cod and pin = $pin ;
    ''');
    return hotel;
  }

  Future<List<Map<String, Map<String, dynamic>>>> verificaSenhaErrada(
      int cod, int pin) async {
    var existe = await connection.mappedResultsQuery('''
    select count(codh) from hotel where codh = $cod and pin <> $pin; 
    ''');
    return existe;
  }

  Future<List<Map<String, Map<String, dynamic>>>> cadastroHotel(
      int cod, int pin, String nome, String end, String tel) async {
    var s = await connection.mappedResultsQuery('''
    insert into hotel values($cod, $pin, '$nome', '$end', '$tel');
    ''');
    return s;
  }

  Future<List<Map<String, Map<String, dynamic>>>> precoTipoQuartos(
      int cod) async {
    var qts = await connection.mappedResultsQuery('''
    select numquarto, preco, tipo from quartohotel where codhotel = $cod order by numquarto;
    ''');
    return qts;
  }

  Future<List<Map<String, Map<String, dynamic>>>> quartoDisponivel(
      int num, int codh) async {
    DateTime data = DateTime.now();
    var res = await connection.mappedResultsQuery('''
    select esta_disponivel($num, $codh, '$data');
    ''');
    return res;
  }

  Future<List<Map<String, Map<String, dynamic>>>> reservas(int codh) async {
    var res = await connection.mappedResultsQuery('''
    select c.cpf, r.numquarto, e.checkin, e.checkout, r.camaextra 
    from reserva r join estadia e on e.code= r.codestadia join clientes c on c.nro = r.nrocliente   
    where r.codhotel = e.codhotel and r.codhotel = $codh 
    order by e.checkin
    ''');
    return res;
  }

  Future<PostgreSQLResult> cadastrarReserva(
      int numquarto,
      int codh,
      String cpf,
      String camaextra,
      DateTime checkin,
      DateTime checkout) async {
    var res = await connection.query('''
        select cadastrar_reserva($numquarto, $codh, '$cpf',  '$camaextra', '$checkin', '$checkout');
        ''');
    return res;
  }

  Future<List<Map<String, Map<String, dynamic>>>> estadias(int codh) async {
    DateTime data = DateTime.now();
    var res = await connection.mappedResultsQuery('''
    select checkin, checkout, cpf, numquarto from estadia join clientes on nrocliente=nro where code not in (select codestadia from reserva) and codhotel = $codh and '$data' between checkin and checkout
    union
    select e.checkin, e.checkout, c.cpf, e.numquarto from estadia e join reserva r on code = codestadia join clientes c on e.nrocliente=c.nro and e.codhotel = $codh and '$data' between checkin and checkout
    ''');
    return res;
  }

  Future<PostgreSQLResult> cadastrarEstadia(DateTime cckin, DateTime cckout,
      String cpf, int numquarto, int codh) async {
    var res = await connection.query('''
    select cadastrar_estadia('$cckin','$cckout', '$cpf', $numquarto, $codh);
    ''');
    return res;
  }

  Future<List<Map<String, Map<String, dynamic>>>> get_clientes() async {
    var res = await connection.mappedResultsQuery('''
    select nome, endereco, telefone, cpf from clientes;
    ''');
    return res;
  }

  Future<PostgreSQLResult> cadastrarCliente(
      String nome, String endereco, String telefone, String cpf) async {
        var res = await connection.query('''
        select cadastrar_cliente('$nome', '$endereco', '$telefone','$cpf');
        ''');
        return res;
      }

  Future<PostgreSQLResult> setPreco(double  single, double duplo, double casal, double suite, int codh) async {
    var res = await connection.query('''
    select set_valor($single, $duplo, $casal, $suite, $codh);
    ''');
    return res;
  }

  Future<PostgreSQLResult> cadastrarServicoEstadia(String tipo, DateTime data, int numquarto) async {
    var res =  await connection.query('''
    select cadastrar_servico_estadia('$tipo', '$data', $numquarto, $codHotel);
    ''');
    return res;
  }

  Future<List<Map<String, Map<String, dynamic>>>> getServicosEstadias(int codh) async {
    var res = await connection.mappedResultsQuery('''
    select e.numquarto, s.data, n.tipo 
    from servicoestadia s join estadia e on e.code = s.codestadia 
    join servicos n on n.cods = s.codservico
    where e.codhotel = $codh
    order by s.data
    ''');
    return res;
  }

  Future<PostgreSQLResult> cadastrarServico(String tipo, double preco) async {
    var res = await connection.query('''
    select cadastrar_servico('$tipo', $preco);
    ''');
    return res;
  }

  Future<List<Map<String, Map<String, dynamic>>>> getAllServices() async {
    var res = await connection.mappedResultsQuery('''
    select tipo from servicos;
    ''');
    return res;
  }
}
