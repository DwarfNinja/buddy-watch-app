import 'package:buddywatch_app/login.dart';
import 'package:buddywatch_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool? check2 = false;
  bool? check3 = false;
  AuthService authService = AuthService();
  TextEditingController voornaamController = TextEditingController();
  TextEditingController tussenvoegselController = TextEditingController();
  TextEditingController achternaamController = TextEditingController();
  TextEditingController leeftijdController = TextEditingController();
  TextEditingController lengteController = TextEditingController();
  TextEditingController gewichtController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();

  final _text = TextEditingController();
  bool _validateVoornaam = false;
  bool _validateTussenvoegsel = false;
  bool _validateAchternaam = false;
  bool _validateLeeftijd = false;
  bool _validateLengte = false;
  bool _validateGewicht = false;
  bool _validateEmail = false;
  bool _validatePassword = false;
  bool _validatePasswordConfirm = false;
  var errorText1 = "Voornaam kan niet leeg zijn";
  var errorText2 = "Tussenvoegsel kan niet leeg zijn";
  var errorText3 = "Achternaam kan niet leeg zijn";
  var errorText4 = "Leeftijd kan niet leeg zijn";
  var errorText5 = "Lengte kan niet leeg zijn";
  var errorText6 = "Gewicht kan niet leeg zijn";
  var errorText7 = "E-mailadres kan niet leeg zijn";
  var errorText8 = "Wachtwoord moet minimaal 6 tekens bevatten";
  var errorText9 = "Wachtwoord moet minimaal 6 tekens bevatten";

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Expanded(
            flex: 3,
            child: Center(
              child: Text(
                'BuddyWatch',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 11,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 15.0, bottom: 15.0, left: 15.0, right: 15.0),
                child: Scrollbar(
                  thumbVisibility: true,
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 15.0, right: 15.0),
                          child: TextField(
                              controller: voornaamController,
                              decoration: InputDecoration(
                                labelText: 'Voornaam',
                                errorText:
                                    _validateVoornaam ? errorText1 : null,
                              ),
                              keyboardType: TextInputType.emailAddress),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 15.0, right: 15.0),
                          child: TextField(
                            controller: tussenvoegselController,
                            decoration: InputDecoration(
                              labelText: 'Tussenvoegsel',
                              errorText:
                                  _validateTussenvoegsel ? errorText2 : null,
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 15.0, right: 15.0),
                          child: TextField(
                            controller: achternaamController,
                            decoration: InputDecoration(
                              labelText: 'Achternaam',
                              errorText:
                                  _validateAchternaam ? errorText3 : null,
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 15.0, right: 15.0),
                          child: TextField(
                            controller: leeftijdController,
                            decoration: InputDecoration(
                              labelText: 'Geboortedatum',
                              errorText: _validateLeeftijd ? errorText4 : null,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 15.0, right: 15.0),
                          child: TextField(
                            controller: lengteController,
                            decoration: InputDecoration(
                              labelText: 'Lengte',
                              errorText: _validateLengte ? errorText5 : null,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 15.0, right: 15.0),
                          child: TextField(
                            controller: gewichtController,
                            decoration: InputDecoration(
                              labelText: 'Gewicht',
                              errorText: _validateGewicht ? errorText6 : null,
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        // const Text('Error Showed if Field is Empty on Submit button Pressed'),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 15.0, right: 15.0),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: 'E-mailadres',
                              errorText: _validateEmail ? errorText7 : null,
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        // const Text('Error Showed if Field is Empty on Submit button Pressed'),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 15.0, right: 15.0),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Wachtwoord',
                              errorText: _validatePassword ? errorText8 : null,
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        // const Text('Error Showed if Field is Empty on Submit button Pressed'),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 15.0, right: 15.0),
                          child: TextField(
                            controller: passwordConfirmationController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Wachtwoord bevestigen',
                              errorText:
                                  _validatePasswordConfirm ? errorText9 : null,
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 15.0, right: 15.0),
                          child: CheckboxListTile(
                            //checkbox positioned at right
                            value: check2,
                            controlAffinity: ListTileControlAffinity.leading,
                            //checkbox at left
                            onChanged: (bool? value) {
                              setState(() {
                                check2 = value;
                              });
                            },
                            title: const Text(
                                "Ik ga akkoord met de algemene voorwaarden"),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 15.0, right: 15.0),
                          child: CheckboxListTile(
                            //checkbox positioned at right
                            value: check3,
                            controlAffinity: ListTileControlAffinity.leading,
                            //checkbox at left
                            onChanged: (bool? value) {
                              setState(() {
                                check3 = value;
                              });
                            },
                            title: const Text(
                                "Ik ga akkoord met de privacy verklaring"),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey.shade900),
                            onPressed: () {
                              setState(() {
                                String formattedDate = leeftijdController.text;
                                int parsedLengte = int.parse(lengteController.text);
                                int parsedGewicht = int.parse(gewichtController.text);

                                voornaamController.text.isEmpty ? _validateVoornaam = true : _validateVoornaam = false;
                                achternaamController.text.isEmpty ? _validateAchternaam = true : _validateAchternaam = false;
                                leeftijdController.text.isEmpty ? _validateLeeftijd = true : _validateLeeftijd = false;
                                lengteController.text.isEmpty ? _validateLengte = true : _validateLengte = false;
                                gewichtController.text.isEmpty ? _validateGewicht = true : _validateGewicht = false;
                                emailController.text.isEmpty ? _validateEmail = true : _validateEmail = false;
                                passwordController.text.isEmpty ? _validatePassword = true : _validatePassword = false;
                                passwordConfirmationController.text.isEmpty ? _validatePasswordConfirm = true : _validatePasswordConfirm = false;
                                
                                if (!emailController.text
                                    .toString()
                                    .contains("@")) {
                                  _validateEmail = true;
                                  errorText7 = "Email bestaat niet";
                                }
                                if (passwordController.text !=
                                    passwordConfirmationController.text) {
                                  _validatePasswordConfirm = true;
                                  errorText9 = "Wachtwoord komt niet overeen";
                                }
                                if (passwordController.text.length < 6) {
                                  _validatePasswordConfirm = true;
                                }
                                if (passwordConfirmationController.text.length <
                                    6) {
                                  _validatePasswordConfirm = true;
                                }
                                if (!_validateEmail &&
                                    !_validatePassword &&
                                    !_validatePassword) {
                                  authService
                                      .signUp(
                                          voornaamController.text,
                                          tussenvoegselController.text,
                                          achternaamController.text,
                                          formattedDate,
                                          parsedLengte,
                                          parsedGewicht,
                                          emailController.text,
                                          passwordController.text)
                                      .then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()),
                                  ));
                                }
                              });
                            },
                            child: const Text('Submit'),
                          ),
                        ),
                      ]);
                    },
                  ),
                ),
              ),
            ),
          ),
          const Spacer(
            flex: 2,
          )
        ],
      ),
    ));
  }
}
