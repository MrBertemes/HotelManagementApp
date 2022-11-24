// ignore_for_file: must_be_immutable
import 'package:bk/main.dart';
import 'package:flutter/material.dart';

class Room extends StatelessWidget {
  int numero;
  int andar;
  double preco;
  Room(
      {super.key,
      required this.numero,
      required this.andar,
      required this.preco});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey,
          width: 3,
        ),
      ),
      child: FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '${andar*100+numero}',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text('Preco')
              ],
            ),
            Text('tipo')
          ],
        ),
      ),
    );
  }
}
