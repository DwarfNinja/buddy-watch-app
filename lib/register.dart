import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  const Register({Key? key})
      : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool? check2 = false;
  bool? check3 = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('BuddyWatch'),
            backgroundColor: Colors.black,
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              labelText: 'Voer hier uw e-mailadres in'),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              labelText: 'Voer hier uw wachtwoord in'),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              labelText: 'Bevestig uw nieuw wachtwoord'),
                        ),
                      ),
                      CheckboxListTile( //checkbox positioned at right
                        value: check2,
                        controlAffinity: ListTileControlAffinity.leading, //checkbox at left
                        onChanged: (bool? value) {
                          setState(() {
                            check2 = value;
                          });
                        },
                        title: const Text("Ik ga akkoord met de algemene voorwaarden"),
                      ),
                      CheckboxListTile( //checkbox positioned at right
                        value: check3,
                        controlAffinity: ListTileControlAffinity.leading, //checkbox at left
                        onChanged: (bool? value) {
                          setState(() {
                            check3 = value;
                          });
                        },
                        title: const Text("Ik ga akkoord met de privacy verklaring"),
                      ),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black
                        ),
                        onPressed: () {
                          print('Hello');
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(30.0),
                color: Colors.black,
                alignment: Alignment.center,
              )
            ],
          ),
        )
    );
  }
}
