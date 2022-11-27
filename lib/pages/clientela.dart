// ignore_for_file: use_build_context_synchronously

import 'package:async_button_builder/async_button_builder.dart';
import 'package:bk/services/client.dart';
import 'package:flutter/material.dart';
import 'package:bk/main.dart';
import 'package:intl/intl.dart';

class ClientelaPage extends StatefulWidget {
  const ClientelaPage({super.key});

  @override
  State<ClientelaPage> createState() => _ClientelaPageState();
}

class _ClientelaPageState extends State<ClientelaPage> {
  late final TextEditingController _nome;
  late final TextEditingController _cpf;
  late final TextEditingController _endereco;
  late final TextEditingController _telefone;


  @override
  void initState() {
    _nome = TextEditingController();
    _cpf = TextEditingController();
    _endereco = TextEditingController();
    _telefone = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nome.dispose();
    _cpf.dispose();
    _endereco.dispose();
    _telefone.dispose();
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
              'Clientes',
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
        itemCount: listCliente.length,
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Nome: ${listCliente[index].nome}'),
                            const Text('   '),
                            Text('CPF: ${listCliente[index].cpf}'),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Endereço: ${listCliente[index].endereco}'),
                            const Text('   '),
                            Text('Telefone: ${listCliente[index].telefone}'),
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
                title: const Text('Novo Cliente'),
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _nome,
                          decoration: const InputDecoration(
                            labelText: 'Nome',
                            icon: Icon(Icons.account_circle_outlined),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        TextFormField(
                          controller: _cpf,
                          decoration: const InputDecoration(
                            labelText: 'CPF',
                            icon: Icon(Icons.numbers_outlined),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        TextFormField(
                          controller: _endereco,
                          decoration: const InputDecoration(
                            labelText: 'Endereço',
                            icon: Icon(Icons.maps_home_work_outlined),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        TextFormField(
                          controller: _telefone,
                          decoration: const InputDecoration(
                            labelText: 'Telefone',
                            icon: Icon(Icons.phone),
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
                      Client novoCliente =
                          Client(cpf: _cpf.text, nome: _nome.text, endereco: _endereco.text, telefone: _telefone.text);

                      var res = await db.cadastrarCliente(novoCliente.nome,
                          novoCliente.endereco, novoCliente.telefone, novoCliente.cpf);
                      setState(() {
                        listCliente.add(novoCliente);
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
