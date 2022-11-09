// ignore_for_file: unused_field, prefer_final_fields, avoid_unnecessary_containers, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:async_button_builder/async_button_builder.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _cod;
  late final TextEditingController _pin;

  bool _hidePin = true;
  bool _nonexistentCod = false;
  bool _invalidPin = false;
  bool _invalidCod = false;

  @override
  void initState() {
    _cod = TextEditingController();
    _pin = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _cod.dispose();
    _pin.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
                minWidth: viewportConstraints.maxWidth,
              ),
              child: Column(
                children: [
                  Center(
                    heightFactor: 1.7,
                    child: Image(
                      image: AssetImage('assets/imgs/bk.png'),
                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
                  ),
                  // ClipPath(
                  //   clipper: CubicClipper(),
                  //   child: Container(
                  //     height: MediaQuery.of(context).size.height * 0.43,
                  //     decoration: BoxDecoration(
                  //       gradient: LinearGradient(
                  //         begin: Alignment.topCenter,
                  //         end: Alignment.bottomCenter,
                  //         colors: [
                  //           Colors.blue.withOpacity(0.40),
                  //           Colors.lightBlue.withOpacity(0.20),
                  //           Colors.blueGrey.withOpacity(0.20),
                  //           Colors.grey.withOpacity(0.20),
                  //         ],
                  //       ),
                  //     ),
                  //     child: Center(
                  //       heightFactor: 1.7,
                  //       child: Image(
                  //         image: AssetImage('assets/images/logoblue.png'),
                  //         width: MediaQuery.of(context).size.width * 0.5,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Container(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 50.0),
                    width: MediaQuery.of(context).size.width * 0.9,
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
                            if (_nonexistentCod) {
                              return '*Não há hotel com esse código';
                            }
                            if (_invalidCod) {
                              return '*Código inválido';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
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
                          autovalidateMode: AutovalidateMode.always,
                          validator: (text) {
                            if (_invalidPin) {
                              return '*Pin inválido';
                            }
                            return null;
                          },
                          enableSuggestions: false,
                          autocorrect: false,
                        ),
                        // Padding(padding: EdgeInsets.all(10.0)),
                        Padding(padding: EdgeInsets.all(30.0)),
                        AsyncButtonBuilder(
                          child: Text(
                            'Entrar',
                            style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          loadingWidget: CircularProgressIndicator(
                            strokeWidth: 3.0,
                          ),
                          onPressed: () async {},
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
                          // ignore: sort_child_properties_last
                          child: const Text('Cadastrar'),
                          style: TextButton.styleFrom(
                            textStyle: TextStyle(
                                color: Colors.blue[900],
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                            backgroundColor: Colors.grey,
                            padding: EdgeInsets.all(10.0),
                            minimumSize: Size(viewportConstraints.maxWidth, 60),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.blueGrey, width: 2.0),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () async {
                            await Navigator.popAndPushNamed(context, '/signup');
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
