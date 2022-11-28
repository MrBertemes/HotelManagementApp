// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously
import 'package:async_button_builder/async_button_builder.dart';
import 'package:bk/main.dart';
import 'package:bk/model/client.dart';
import 'package:bk/model/reserv.dart';
import 'package:bk/model/service.dart';
import 'package:bk/model/stay.dart';
import 'package:flutter/material.dart';

class HotelPage extends StatefulWidget {
  const HotelPage({super.key});

  @override
  State<HotelPage> createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/login');
          },
        ),
        backgroundColor: Colors.lightBlue,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              nomeHotel,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(enderecoHotel),
                Text('  -  '),
                Text(telefoneHotel),
              ],
            ),
          ],
        ),
        centerTitle: true,
        elevation: 3,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
                minWidth: viewportConstraints.maxWidth,
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 50.0),
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AsyncButtonBuilder(
                          loadingWidget: CircularProgressIndicator(
                            strokeWidth: 3.0,
                          ),
                          onPressed: () async {
                            var res = await db.precoTipoQuartos(codHotel);
                            for (var e in res) {
                              for (var k in e.values) {
                                var andar = k['numquarto'] ~/ 100;
                                var qt = k['numquarto'] % 100;
                                matrixPreco[andar - 1][qt - 1] = k['preco'];
                                matrixTipo[andar - 1][qt - 1] = k['tipo'];
                                matrixNum[andar - 1][qt - 1] = k['numquarto'];
                                var disp = await db.quartoDisponivel(
                                    k['numquarto'], codHotel);
                                for (var q in disp.first.values) {
                                  for (var v in q.keys) {
                                    matrixDisponivel[andar - 1][qt - 1] = q[v];
                                  }
                                }
                              }
                            }
                            Navigator.popAndPushNamed(context, '/chambre');
                          },
                          builder: (context, child, callback, _) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(10.0),
                                minimumSize:
                                    Size(viewportConstraints.maxWidth, 60),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.blueGrey, width: 2.0),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: Colors.grey,
                                elevation: 2.0,
                              ),
                              onPressed: callback,
                              child: child,
                            );
                          },
                          child: Text(
                            'Quartos',
                            style: TextStyle(color: Colors.blue[900]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AsyncButtonBuilder(
                          loadingWidget: CircularProgressIndicator(
                            strokeWidth: 3.0,
                          ),
                          onPressed: () async {
                            listReserv = [];
                            var res = await db.reservas(codHotel);
                            for (var e in res) {
                              Reserv reserva = Reserv(
                                  cpf: '',
                                  numquarto: 0,
                                  ce: 's',
                                  checkin: DateTime.now(),
                                  checkout: DateTime.now());
                              for (var v in e.values) {
                                for (var k in v.keys) {
                                  if (k == 'cpf') {
                                    reserva.cpf = v[k];
                                  } else if (k == 'numquarto') {
                                    reserva.numquarto = v[k];
                                  } else if (k == 'camaextra') {
                                    reserva.ce = v[k];
                                  } else if (k == 'checkin') {
                                    reserva.checkin = v[k];
                                  } else if (k == 'checkout') {
                                    reserva.checkout = v[k];
                                  }
                                }
                              }
                              listReserv.add(reserva);
                            }
                            Navigator.popAndPushNamed(context, '/reserva');
                          },
                          builder: (context, child, callback, _) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(10.0),
                                minimumSize:
                                    Size(viewportConstraints.maxWidth, 60),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.blueGrey, width: 2.0),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: Colors.grey,
                                elevation: 2.0,
                              ),
                              onPressed: callback,
                              child: child,
                            );
                          },
                          child: Text(
                            'Reservas',
                            style: TextStyle(color: Colors.blue[900]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AsyncButtonBuilder(
                          loadingWidget: CircularProgressIndicator(
                            strokeWidth: 3.0,
                          ),
                          onPressed: () async {
                            listStay = [];
                            var res = await db.estadias(codHotel);
                            for (var e in res) {
                              Stay st = Stay(
                                  cpf: '',
                                  numquarto: 0,
                                  checkin: DateTime.now(),
                                  checkout: DateTime.now());
                              for (var v in e.values) {
                                for (var k in v.keys) {
                                  if (k == 'cpf') {
                                    st.cpf = v[k];
                                  } else if (k == 'numquarto') {
                                    st.numquarto = v[k];
                                  } else if (k == 'checkin') {
                                    st.checkin = v[k];
                                  } else if (k == 'checkout') {
                                    st.checkout = v[k];
                                  }
                                }
                              }
                              listStay.add(st);
                            }
                            Navigator.popAndPushNamed(context, '/estadia');
                          },
                          builder: (context, child, callback, _) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(10.0),
                                minimumSize:
                                    Size(viewportConstraints.maxWidth, 60),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.blueGrey, width: 2.0),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: Colors.grey,
                                elevation: 2.0,
                              ),
                              onPressed: callback,
                              child: child,
                            );
                          },
                          child: Text(
                            'Estadias',
                            style: TextStyle(color: Colors.blue[900]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AsyncButtonBuilder(
                          loadingWidget: CircularProgressIndicator(
                            strokeWidth: 3.0,
                          ),
                          onPressed: () async {
                            listCliente = [];
                            var res = await db.get_clientes();
                            for (var e in res) {
                              Client cl = Client(
                                cpf: '',
                                nome: '',
                                endereco: '',
                                telefone: '',
                              );
                              for (var v in e.values) {
                                for (var k in v.keys) {
                                  if (k == 'cpf') {
                                    cl.cpf = v[k];
                                  } else if (k == 'nome') {
                                    cl.nome = v[k];
                                  } else if (k == 'endereco') {
                                    cl.endereco = v[k];
                                  } else if (k == 'telefone') {
                                    cl.telefone = v[k];
                                  }
                                }
                              }
                              listCliente.add(cl);
                            }
                            Navigator.popAndPushNamed(context, '/client');
                          },
                          builder: (context, child, callback, _) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(10.0),
                                minimumSize:
                                    Size(viewportConstraints.maxWidth, 60),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.blueGrey, width: 2.0),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: Colors.grey,
                                elevation: 2.0,
                              ),
                              onPressed: callback,
                              child: child,
                            );
                          },
                          child: Text(
                            'Clientes',
                            style: TextStyle(color: Colors.blue[900]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AsyncButtonBuilder(
                          loadingWidget: CircularProgressIndicator(
                            strokeWidth: 3.0,
                          ),
                          onPressed: () async {
                            listService = [];
                            var res = await db.getServicosEstadias(codHotel);
                            for (var e in res) {
                              Service sc = Service(
                                data: DateTime.now(),
                                descricao: '',
                                numquarto: 0,
                              );
                              for (var v in e.values) {
                                for (var k in v.keys) {
                                  if (k == 'data') {
                                    sc.data = v[k];
                                  } else if (k == 'numquarto') {
                                    sc.numquarto = v[k];
                                  } else if (k == 'tipo') {
                                    sc.descricao = v[k];
                                  }
                                }
                              }
                              listService.add(sc);
                            }
                            Navigator.popAndPushNamed(context, '/services');
                          },
                          builder: (context, child, callback, _) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(10.0),
                                minimumSize:
                                    Size(viewportConstraints.maxWidth, 60),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.blueGrey, width: 2.0),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: Colors.grey,
                                elevation: 2.0,
                              ),
                              onPressed: callback,
                              child: child,
                            );
                          },
                          child: Text(
                            'Serviços',
                            style: TextStyle(color: Colors.blue[900]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
