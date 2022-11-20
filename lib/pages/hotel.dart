// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:bk/main.dart';
import 'package:bk/widgets/room.dart';
import 'package:flutter/material.dart';

class HotelPage extends StatefulWidget {
  const HotelPage({super.key});

  @override
  State<HotelPage> createState() => _HotelPageState();
}

class _HotelPageState extends State<HotelPage> {
  final List<Room> _listRoom = <Room>[
    Room(numero: 101, andar: 1, preco: 50),
    Room(numero: 102, andar: 1, preco: 50),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      // body: ListView.builder(
      //   itemCount: _listRoom.length,
      //   itemBuilder: ((context, index) {
      //     return Column(
      //       children: <Widget>[
      //         Card(
      //           child: _listRoom[index],
      //         ),
      //       ],
      //     );
      //   }),
      // ),
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
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(10.0),
                            minimumSize: Size(viewportConstraints.maxWidth, 60),
                            shape: RoundedRectangleBorder(
                              side:
                                  BorderSide(color: Colors.blueGrey, width: 2.0),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: Colors.grey,
                            elevation: 2.0,
                          ),
                          onPressed: () {
                            Navigator.popAndPushNamed(context, '/chambre');
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
                              side:
                                  BorderSide(color: Colors.blueGrey, width: 2.0),
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
                              side:
                                  BorderSide(color: Colors.blueGrey, width: 2.0),
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
                              side:
                                  BorderSide(color: Colors.blueGrey, width: 2.0),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.popAndPushNamed(context, '/login');
        },
      ),
    );
  }
}
