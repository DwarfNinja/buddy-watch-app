
import 'package:buddywatch_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {

  const Profile({Key? key})
      : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
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
                      top: 15.0, bottom: 0.0, left: 15.0, right: 15.0),
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Voornaam:',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(bottom: 15.0, right: 15.0),
                            child: TextField(
                              controller: voornaamController,
                              decoration: InputDecoration(
                                hintText: "Voornaam",
                                labelText: authService.getUser()!.userMetadata!["first_name"].toString(),
                                errorText:
                                _validateVoornaam ? errorText1 : null,
                              ),
                              keyboardType: TextInputType.emailAddress
                            ),
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Tussenvoegsel:',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(bottom: 15.0, right: 15.0),
                            child: TextField(
                              controller: tussenvoegselController,
                              decoration: InputDecoration(
                                labelText: authService.getUser()!.userMetadata!["proposition"].toString(),
                                errorText:
                                _validateTussenvoegsel ? errorText2 : null,
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Achternaam:',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(bottom: 15.0, right: 15.0),
                            child: TextField(
                              controller: achternaamController,
                              decoration: InputDecoration(
                                labelText: authService.getUser()!.userMetadata!["last_name"].toString(),
                                errorText:
                                _validateAchternaam ? errorText3 : null,
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Leeftijd:',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(bottom: 15.0, right: 15.0),
                            child: TextField(
                              controller: leeftijdController,
                              decoration: InputDecoration(
                                labelText: authService.getUser()!.userMetadata!["age"].toString(),
                                errorText: _validateLeeftijd ? errorText4 : null,
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Lengte:',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(bottom: 15.0, right: 15.0),
                            child: TextField(
                              controller: lengteController,
                              decoration: InputDecoration(
                                labelText: authService.getUser()!.userMetadata!["height"].toString(),
                                errorText: _validateLengte ? errorText5 : null,
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Gewicht:',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(bottom: 15.0, right: 15.0),
                            child: TextField(
                              controller: gewichtController,
                              decoration: InputDecoration(
                                labelText: authService.getUser()!.userMetadata!["weight"].toString(),
                                errorText: _validateGewicht ? errorText6 : null,
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'E-mailadres:',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(bottom: 15.0, right: 15.0),
                            child: TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: authService.getUser()!.email.toString(),
                                errorText: _validateEmail ? errorText7 : null,
                              ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Wachtwoord:',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
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
                              onChanged: (text) => setState(() => _text),
                            ),
                          ),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Wachtwoord bevestigen:',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ),
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
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueGrey.shade900
                              ),
                              onPressed: () {
                                setState(() {
                                  if (voornaamController.text == null) {
                                    voornaamController.text = authService.getUser()!.userMetadata!["first_name"].toString();
                                  }
                                  if (tussenvoegselController.text == null) {
                                    tussenvoegselController.text = authService.getUser()!.userMetadata!["proposition"].toString();
                                  }
                                  if (achternaamController.text == null) {
                                    achternaamController.text = authService.getUser()!.userMetadata!["last_name"].toString();
                                  }
                                  if (leeftijdController.text == null) {
                                    leeftijdController.text = authService.getUser()!.userMetadata!["age"].toString();
                                  }
                                  if (lengteController.text == null) {
                                    lengteController.text = authService.getUser()!.userMetadata!["height"].toString();
                                  }
                                  if (gewichtController.text == null) {
                                    gewichtController.text = authService.getUser()!.userMetadata!["weight"].toString();
                                  }
                                  if (emailController.text == null) {
                                    emailController.text = authService.getUser()!.email.toString();
                                  }

                                  int parsedLeeftijd = int.parse(leeftijdController.text);
                                  int parsedLengte = int.parse(lengteController.text);
                                  int parsedGewicht = int.parse(gewichtController.text);

                                  if (!emailController.text
                                      .toString()
                                      .contains("@")) {
                                    _validateEmail = true;
                                    errorText7 = "Email bestaat niet";
                                  }

                                  if (passwordController.text != null) {
                                    if (passwordController.text !=
                                        passwordConfirmationController.text) {
                                      _validatePasswordConfirm = true;
                                      errorText9 = "Wachtwoord komt niet overeen";
                                    }
                                    if (passwordController.text.length < 6) {
                                      _validatePasswordConfirm = true;
                                    }
                                    if (passwordConfirmationController.text.length < 6) {
                                      _validatePasswordConfirm = true;
                                    }
                                  }
                                  authService.updateUser(
                                      voornaamController.text,
                                      tussenvoegselController.text,
                                      achternaamController.text,
                                      parsedLeeftijd,
                                      parsedLengte,
                                      parsedGewicht,
                                      emailController.text,
                                      passwordController.text
                                  );
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
      ),
    );
  }
}