import 'package:buddywatch_app/dashboard.dart';
import 'package:buddywatch_app/register.dart';
import 'package:buddywatch_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {

  const Login({Key? key})
      : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isChecked = false;
  AuthService authService = AuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  'BuddyWatch',
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          hintText: 'Voer hier uw e-mailadres in.',
                          labelText: 'E-mailadres'
                        ),
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          hintText: 'Voer hier uw wachtwoord in',
                          labelText: 'Wachtwoord'
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children:  [
                          Checkbox(
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                          const Text(
                            'Ingelogd blijven'
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          primary: Colors.black,
                          minimumSize: const Size.fromHeight(50), // NEW
                        ),
                        onPressed: () {
                          authService.logIn(emailController.text, passwordController.text);
                          print(authService.isLoggedIn());
                          if(authService.isLoggedIn()) {

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Dashboard()),
                            );
                          }
                        },
                        child: const Text(
                          'Inloggen',
                          style: TextStyle(
                            fontSize: 17
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          primary: Colors.white,
                          minimumSize: const Size.fromHeight(50), // NEW
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Register()),
                          );
                        },
                        child: const Text(
                          'Registreren',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
