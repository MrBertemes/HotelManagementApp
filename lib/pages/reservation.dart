// ignore_for_file: prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:async_button_builder/async_button_builder.dart';
import 'package:bk/model/reserv.dart';
import 'package:flutter/material.dart';
import 'package:bk/main.dart';
import 'package:intl/intl.dart';


class ReservaPage extends StatefulWidget {
  const ReservaPage({super.key});

  @override
  State<ReservaPage> createState() => _ReservaPageState();
}

class _ReservaPageState extends State<ReservaPage> {
  final camaExtra = ValueNotifier('');
  final camaOpcoes = <String>['Sim', 'Não'];
  late final TextEditingController _cpf;
  late final TextEditingController _qt;
  late final TextEditingController _ce;
  late final TextEditingController _checkin;
  late final TextEditingController _checkout;

  @override
  void initState() {
    _cpf = TextEditingController();
    _qt = TextEditingController();
    _ce = TextEditingController();
    _checkin = TextEditingController();
    _checkout = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _cpf.dispose();
    _qt.dispose();
    _ce.dispose();
    _checkin.dispose();
    _checkout.dispose();
    super.dispose();
  }

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
        itemCount: listReserv.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    alignment: AlignmentDirectional.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.lightBlue,
                        width: 3,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text('Cliente: ${listReserv[index].cpf}'),
                            const Text(' - '),
                            Text('Quarto: ${listReserv[index].numquarto}'),
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                    'Checkin: ${DateFormat.yMMMd().format(listReserv[index].checkin)}'),
                                Text(
                                    'Checkout: ${DateFormat.yMMMd().format(listReserv[index].checkout)}'),
                              ],
                            ),
                            const Text('    '),
                            Text('Cama Extra: ${listReserv[index].ce}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                scrollable: true,
                title: const Text('Nova Reserva'),
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _cpf,
                          decoration: const InputDecoration(
                            labelText: 'CPF',
                            icon: Icon(Icons.account_circle_outlined),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        TextFormField(
                          controller: _qt,
                          decoration: const InputDecoration(
                            labelText: 'Número Quarto',
                            icon: Icon(Icons.door_front_door_outlined),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        TextField(
                          controller:
                              _checkin, //editing controller of this TextField
                          decoration: const InputDecoration(
                              icon: Icon(
                                  Icons.calendar_today), //icon of text field
                              labelText: "Checkin" //label text of field
                              ),
                          readOnly:
                              true, //set it true, so that user will not able to edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100));

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);

                              setState(() {
                                _checkin.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            }
                          },
                        ),
                        TextField(
                          controller:
                              _checkout, //editing controller of this TextField
                          decoration: const InputDecoration(
                              icon: Icon(
                                  Icons.calendar_today), //icon of text field
                              labelText: "Checkout" //label text of field
                              ),
                          readOnly:
                              true, //set it true, so that user will not able to edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now().add(const Duration(days: 1)),
                                firstDate: DateTime.now().add(const Duration(days: 1)),
                                lastDate: DateTime(2100));

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);

                              setState(() {
                                _checkout.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            }
                          },
                        ),
                        SizedBox(
                          child: ValueListenableBuilder(
                            valueListenable: camaExtra,
                            builder: (BuildContext context, String value, _) {
                              return DropdownButton<String>(
                                hint: const Text("Cama Extra"),
                                value: (value.isEmpty ? null : value),
                                onChanged: camaOpcoes.isNotEmpty
                                    ? (escolha) =>
                                        camaExtra.value = escolha.toString()
                                    : null,
                                items: camaOpcoes
                                    .map(
                                      (op) => DropdownMenuItem(
                                        value: op,
                                        child: Text(op),
                                      ),
                                    )
                                    .toList(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancelar"),
                  ),
                  AsyncButtonBuilder(
                    loadingWidget: const CircularProgressIndicator(
                      strokeWidth: 3.0,
                    ),
                    onPressed: () async {
                      Reserv novaReserva = Reserv(
                          cpf: _cpf.text,
                          numquarto: int.parse(_qt.text),
                          ce: camaExtra.value,
                          checkin: DateTime.parse(_checkin.text),
                          checkout: DateTime.parse(_checkout.text));
                      var res = await db.cadastrarReserva(
                          novaReserva.numquarto,
                          codHotel,
                          novaReserva.cpf,
                          novaReserva.ce,
                          novaReserva.checkin,
                          novaReserva.checkout);
                      setState(() {
                        listReserv.add(novaReserva);
                      });
                      Navigator.pop(context);
                    },
                    builder: (context, child, callback, _) {
                      return TextButton(
                        onPressed: callback,
                        child: child,
                      );
                    },
                    child: const Text(
                      'Criar',
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
