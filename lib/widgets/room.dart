// ignore_for_file: must_be_immutable
import 'package:bk/main.dart';
import 'package:flutter/material.dart';

class Room extends StatelessWidget {
  int numero;
  String tipo;
  double preco;
  Room(
      {super.key,
      required this.numero,
      required this.tipo,
      required this.preco});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: matrixDisponivel[iGlobal][jGlobal] == 0 ?Colors.green : Colors.grey,
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
                  '${matrixNum[iGlobal][jGlobal]}',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(' - Preço: ${matrixPreco[iGlobal][jGlobal]}')
              ],
            ),
            Text('Tipo: ${matrixTipo[iGlobal][jGlobal]}'),
          ],
        ),
      ),
    );
  }
}
