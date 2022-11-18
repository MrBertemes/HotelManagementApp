// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Nome'),
                Text('endereco'),
              ],
            ),
            Text('num')
          ],
        ),
        centerTitle: true,
        elevation: 3,
      ),
      // body: LayoutBuilder(
      //   builder: (p0, p1) {
      //     return SingleChildScrollView(
      //       scrollDirection: Axis.horizontal,
      //     );
      //   },
      // ),
      body: ListView.builder(
        itemCount: _listRoom.length,
        itemBuilder: ((context, index) {
          return Column(
            children: <Widget>[
              Card(
                child: _listRoom[index],
              ),
            ],
          );
        }),
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
