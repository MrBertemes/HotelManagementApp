// ignore_for_file: prefer_const_constructors

import 'package:bk/widgets/corridor.dart';
import 'package:flutter/material.dart';
import 'package:bk/main.dart';

class ChambrePage extends StatefulWidget {
  const ChambrePage({super.key});

  @override
  State<ChambrePage> createState() => _ChambrePageState();
}

class _ChambrePageState extends State<ChambrePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/hotel');
          },
        ),
        backgroundColor: Colors.lightBlue,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              nomeHotel,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(enderecoHotel),
                const Text('  -  '),
                Text(telefoneHotel),
              ],
            ),
          ],
        ),
        centerTitle: true,
        elevation: 3,
      ),
      body: ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: qtAndarHotel,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 100,
                  child: Corridor(andar: index + 1),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
