// ignore_for_file: must_be_immutable, prefer_const_constructors
import 'package:bk/main.dart';
import 'package:bk/widgets/room.dart';
import 'package:flutter/material.dart';

class Corridor extends StatefulWidget {
  int andar;
  Corridor({super.key, required this.andar});

  @override
  State<Corridor> createState() => _CorridorState();
}

class _CorridorState extends State<Corridor> {

int get qtQuartos {
    if (widget.andar <= 5) {
      return 10;
    } else if (widget.andar > 5 && widget.andar < 8) {
      return 5;
    } else {
      return 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: qtQuartos,
      itemBuilder: (context, index) {
        jGlobal = index;
        return Card(
          child: Room(tipo: 'S', numero: index+1, preco: 0),
        );
      },
    );
  }
}
