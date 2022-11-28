// ignore_for_file: use_build_context_synchronously

import 'package:async_button_builder/async_button_builder.dart';
import 'package:bk/model/service.dart';
import 'package:flutter/material.dart';
import 'package:bk/main.dart';
import 'package:intl/intl.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  final servico = ValueNotifier('');
  late final TextEditingController _tipo;
  late final TextEditingController _preco;
  late final TextEditingController _tipoNovo;
  late final TextEditingController _data;
  late final TextEditingController _qt;

  @override
  void initState() {
    _preco = TextEditingController();
    _tipo = TextEditingController();
    _tipoNovo = TextEditingController();
    _qt = TextEditingController();
    _data = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _preco.dispose();
    _tipo.dispose();
    _tipoNovo.dispose();
    _qt.dispose();
    _data.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  _tipoNovo.text = '';
                  return AlertDialog(
                    scrollable: true,
                    title: const Text('Novo Serviço'),
                    content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: _tipoNovo,
                              decoration: const InputDecoration(
                                labelText: 'Tipo',
                                icon: Icon(Icons.add_home_work_outlined),
                              ),
                              keyboardType: TextInputType.text,
                            ),
                            TextFormField(
                              controller: _preco,
                              decoration: const InputDecoration(
                                labelText: 'Preço',
                                icon: Icon(Icons.monetization_on_outlined),
                              ),
                              keyboardType: TextInputType.text,
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
                          var res = await db.cadastrarServico(
                              _tipoNovo.text, double.parse(_preco.text));
                          listTipoServico.add(_tipoNovo.text);
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
            icon: const Icon(Icons.add, color: Colors.white),
          )
        ],
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
              'Serviços',
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
        itemCount: listService.length,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                                'Número Quarto: ${listService[index].numquarto}'),
                            const Text('   '),
                            Text('Tipo: ${listService[index].descricao}'),
                          ],
                        ),
                        Text('Data: ${DateFormat.yMMMd().format(listService[index].data)}')
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
                title: const Text('Nova Estadia'),
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          child: ValueListenableBuilder(
                            valueListenable: servico,
                            builder: (BuildContext context, String value, _) {
                              return DropdownButton<String>(
                                hint: const Text("Tipos"),
                                value: (value.isEmpty ? null : value),
                                onChanged: listTipoServico.isNotEmpty
                                    ? (escolha) =>
                                        servico.value = escolha.toString()
                                    : null,
                                items: listTipoServico
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
                              _data, //editing controller of this TextField
                          decoration: const InputDecoration(
                              icon: Icon(
                                  Icons.calendar_today), //icon of text field
                              labelText: "Data" //label text of field
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
                                _data.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            }
                          },
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
                      Service sv = Service(
                        numquarto: int.parse(_qt.text),
                        data: DateTime.parse(_data.text),
                        descricao: servico.value,
                      );
                      var res = await db.cadastrarServicoEstadia(
                        servico.value,
                        DateTime.parse(_data.text),
                        int.parse(_qt.text),
                      );
                      setState(() {
                        listService.add(sv);
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
