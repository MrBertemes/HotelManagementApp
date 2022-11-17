// ignore_for_file: prefer_const_constructors

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
  DatabaseHelper db = DatabaseHelper();

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
                children: <Widget>[
                  Center(
                    heightFactor: 1.7,
                    child: Image(
                      image: AssetImage('assets/images/bk.png'),
                      width: MediaQuery.of(context).size.width * 0.15,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
