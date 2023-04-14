import 'package:buddywatch_app/login.dart';
import 'package:buddywatch_app/services/auth_service.dart';
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
  AuthService authService = AuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();

  final _text = TextEditingController();
  bool _validateEmail = false;
  bool _validatePassword = false;
  bool _validatePasswordConfirm = false;
  var errorText1 = "E-mailadres kan niet leeg zijn";
  var errorText2 = "Wachtwoord moet minimaal 6 tekens bevatten";
  var errorText3 = "Wachtwoord moet minimaal 6 tekens bevatten";

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }
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
                      // const Text('Error Showed if Field is Empty on Submit button Pressed'),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'E-mailadres',
                          errorText: _validateEmail ? errorText1 : null,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),

                      // const Text('Error Showed if Field is Empty on Submit button Pressed'),
                      TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'Wachtwoord',
                          errorText: _validatePassword ? errorText2 : null,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      // const Text('Error Showed if Field is Empty on Submit button Pressed'),
                      TextField(
                        controller: passwordConfirmationController,
                        decoration: InputDecoration(
                          labelText: 'Wachtwoord bevestigen',
                          errorText: _validatePasswordConfirm
                              ? errorText3
                              : null,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      CheckboxListTile( //checkbox positioned at right
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
                      CheckboxListTile( //checkbox positioned at right
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

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black
                        ),
                        onPressed: () {
                          setState(() {
                            emailController.text.isEmpty ?
                            _validateEmail = true : _validateEmail = false;
                            passwordController.text.isEmpty ?
                            _validatePassword = true : _validatePassword =
                            false;
                            passwordConfirmationController.text.isEmpty
                                ? _validatePasswordConfirm = true
                                : _validatePasswordConfirm = false;
                            if (!emailController.text.toString().contains(
                                "@")) {
                              _validateEmail = true;
                              errorText1 = "Email bestaat niet";
                            }
                            if (passwordController.text !=
                                passwordConfirmationController.text) {
                              _validatePasswordConfirm = true;
                              errorText3 = "Wachtwoord komt niet overeen";
                            }
                            if (passwordController.text.length < 6) {
                              _validatePasswordConfirm = true;
                            }
                            if (passwordConfirmationController.text.length <
                                6) {
                              _validatePasswordConfirm = true;
                            }
                            print(_validateEmail);
                            print(_validatePassword);
                            print(_validatePasswordConfirm);
                            if (!_validateEmail && !_validatePassword &&
                                !_validatePassword) {
                              authService.signUp(emailController.text,
                                  passwordController.text);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()),
                              );
                            }
                          }
                          );

                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                color: Colors.black,
                alignment: Alignment.center,
              )
            ],
          ),
        )
    );
  }
}