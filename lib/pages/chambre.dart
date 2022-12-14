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
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/hotel');
          },
        ),
        backgroundColor: Colors.lightBlue,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Quartos',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              nomeHotel,
            ),
          ],
        ),
        centerTitle: true,
        elevation: 3,
      ),
      body: ListView.builder(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: qtAndarHotel,
        itemBuilder: (context, index) {
          iGlobal = index;
          return Container(
            padding: const EdgeInsets.all(10),
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
