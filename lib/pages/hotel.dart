// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously
import 'package:async_button_builder/async_button_builder.dart';
import 'package:bk/main.dart';
import 'package:bk/widgets/room.dart';
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
                              var i = 0;
                              for (var k in e.values) {
                                var andar = k['numquarto'] ~/ 100;
                                var qt = k['numquarto'] % 100;
                                matrixPreco[andar - 1][qt - 1] = k['preco'];
                                matrixTipo[andar - 1][qt - 1] = k['tipo'];
                                matrixNum[andar - 1][qt - 1] = k['numquarto'];
                                var disp = await db.quartoDisponivel(
                                    k['numquarto'], codHotel);
                                for (var q in disp.first.values) {
                                  for(var v in q.keys){
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
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(10.0),
                            minimumSize: Size(viewportConstraints.maxWidth, 60),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.blueGrey, width: 2.0),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: Colors.grey,
                            elevation: 2.0,
                          ),
                          onPressed: () {},
                          child: Text(
                            'Reservas',
                            style: TextStyle(color: Colors.blue[900]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(10.0),
                            minimumSize: Size(viewportConstraints.maxWidth, 60),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.blueGrey, width: 2.0),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: Colors.grey,
                            elevation: 2.0,
                          ),
                          onPressed: () {},
                          child: Text(
                            'Estadias',
                            style: TextStyle(color: Colors.blue[900]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(10.0),
                            minimumSize: Size(viewportConstraints.maxWidth, 60),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.blueGrey, width: 2.0),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: Colors.grey,
                            elevation: 2.0,
                          ),
                          onPressed: () {},
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
