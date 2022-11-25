import 'package:flutter/material.dart';
import 'package:bk/main.dart';

class ReservaPage extends StatefulWidget {
  const ReservaPage({super.key});

  @override
  State<ReservaPage> createState() => _ReservaPageState();
}

class _ReservaPageState extends State<ReservaPage> {
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
              'Reservas',
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
        itemCount: 1,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 100,
                  child: Text('a'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
