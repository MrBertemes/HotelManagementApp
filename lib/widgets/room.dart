// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
    return LayoutBuilder(
      builder: ((context, constraints) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: constraints.maxWidth,
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey,
                  width: 3,
                ),
              ),
              child: FittedBox(
                child: Text(
                  'Andar ${numero.toString()}, no segundo ${andar.toString()}',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
