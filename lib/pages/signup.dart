// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously

import 'package:async_button_builder/async_button_builder.dart';
import 'package:bk/main.dart';
import 'package:bk/services/db.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late final TextEditingController _cod;
  late final TextEditingController _pin;
  late final TextEditingController _nome;
  late final TextEditingController _end;
  late final TextEditingController _tel;
  late final TextEditingController _single;
  late final TextEditingController _duplo;
  late final TextEditingController _casal;
  late final TextEditingController _suite;
  DatabaseHelper db = DatabaseHelper();

  bool _hidePin = true;
  bool _invalidPin = false;
  bool _usedCod = false;

  @override
  void initState() {
    db.openDB();
    _cod = TextEditingController();
    _pin = TextEditingController();
    _nome = TextEditingController();
    _end = TextEditingController();
    _tel = TextEditingController();
    _single = TextEditingController();
    _duplo = TextEditingController();
    _casal = TextEditingController();
    _suite = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _cod.dispose();
    _pin.dispose();
    _nome.dispose();
    _end.dispose();
    _tel.dispose();
    _single.dispose();
    _duplo.dispose();
    _casal.dispose();
    _suite.dispose();
    super.dispose();
  }

  Future<void> cadastroHotel(
      int cod, int pin, String nome, String end, String tel) async {
    var res = await db.cadastroHotel(cod, pin, nome, end, tel);
    var res2 = await db.setPreco(
      double.parse(_single.text),
      double.parse(_duplo.text),
      double.parse(_casal.text),
      double.parse(_suite.text),
      int.parse(_cod.text),
    );
    Navigator.popAndPushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: viewportConstraints.maxWidth,
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    heightFactor: 1.7,
                    child: Image(
                      image: AssetImage('assets/images/bk.png'),
                      width: MediaQuery.of(context).size.width * 0.10,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 50.0),
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextFormField(
                          controller: _cod,
                          decoration: InputDecoration(
                            label: Text(
                              'Código do Hotel',
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 3,
                              ),
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.always,
                          validator: (text) {
                            if (_usedCod) {
                              return '*Código inválido';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                        ),
                        Padding(padding: EdgeInsets.all(8.0)),
                        TextFormField(
                          controller: _pin,
                          obscureText: _hidePin,
                          decoration: InputDecoration(
                            label: Text(
                              'PIN',
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 3,
                              ),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(
                                  () {
                                    _hidePin = !_hidePin;
                                  },
                                );
                              },
                              icon: Icon(_hidePin
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                          enableSuggestions: false,
                          autocorrect: false,
                          keyboardType: TextInputType.number,
                        ),
                        Padding(padding: EdgeInsets.all(8.0)),
                        TextFormField(
                          controller: _nome,
                          decoration: InputDecoration(
                            label: Text(
                              'Nome',
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 3,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        Padding(padding: EdgeInsets.all(8.0)),
                        TextFormField(
                          controller: _end,
                          decoration: InputDecoration(
                            label: Text(
                              'Endereço',
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 3,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        Padding(padding: EdgeInsets.all(8.0)),
                        TextFormField(
                          controller: _tel,
                          decoration: InputDecoration(
                            label: Text(
                              'Telefone',
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 3,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        Padding(padding: EdgeInsets.all(8.0)),
                        TextFormField(
                          controller: _single,
                          decoration: InputDecoration(
                            label: Text(
                              'Valor Single',
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 3,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        Padding(padding: EdgeInsets.all(8.0)),
                        TextFormField(
                          controller: _duplo,
                          decoration: InputDecoration(
                            label: Text(
                              'Valor Duplo',
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 3,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        Padding(padding: EdgeInsets.all(8.0)),
                        TextFormField(
                          controller: _casal,
                          decoration: InputDecoration(
                            label: Text(
                              'Valor Casal',
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 3,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        Padding(padding: EdgeInsets.all(8.0)),
                        TextFormField(
                          controller: _suite,
                          decoration: InputDecoration(
                            label: Text(
                              'Valor Suite',
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 3,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        Padding(padding: EdgeInsets.all(30.0)),
                        AsyncButtonBuilder(
                          loadingWidget: CircularProgressIndicator(
                            strokeWidth: 3.0,
                          ),
                          onPressed: () async {
                            var cod = int.parse(_cod.text);
                            var pin = int.parse(_pin.text);
                            cadastroHotel(
                                cod, pin, _nome.text, _end.text, _tel.text);
                          },
                          builder: (context, child, callback, _) {
                            return TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.grey,
                                backgroundColor: Colors.grey,
                                padding: EdgeInsets.all(10.0),
                                minimumSize:
                                    Size(viewportConstraints.maxWidth, 60),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.blueGrey,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: callback,
                              child: child,
                            );
                          },
                          child: Text(
                            'Criar',
                            style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                height: 2,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    // ignore: prefer_const_literals_to_create_immutables
                                    colors: [
                                      Color.fromARGB(0, 252, 247, 247),
                                      Colors.blueGrey,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                "OU",
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 2,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    // ignore: prefer_const_literals_to_create_immutables
                                    colors: [
                                      Colors.blueGrey,
                                      Color.fromARGB(0, 251, 249, 249),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          child: const Text(
                            'Já tenho uma conta',
                            style: TextStyle(
                                color: Color.fromARGB(255, 13, 71, 161),
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey,
                            padding: EdgeInsets.all(10.0),
                            minimumSize: Size(viewportConstraints.maxWidth, 60),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.blueGrey, width: 2.0),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
