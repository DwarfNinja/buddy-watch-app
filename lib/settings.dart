import 'package:buddywatch_app/color_palette.dart';
import 'package:buddywatch_app/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class Settings extends StatefulWidget {

  const Settings({Key? key})
      : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}
AuthService authService = AuthService();
class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.blueGrey.shade900,
            appBar: AppBar(
              title: const Text('BuddyWatch'),
              centerTitle: true,
              backgroundColor: Colors.black,
            ),
            body: Column(children: [
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(children: [
                        Padding(
                            padding: EdgeInsets.all(25),
                            //apply padding to all four sides
                            child: Align(
                              alignment: Alignment.center,
                              child: InkWell(
                                child: Container(
                                  height: 125.0,
                                  width: 125.0,
                                  color: Colors.transparent,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(20.0))),
                                    child: const Icon(
                                      Icons.logout,
                                      color: Colors.black,
                                      size: 75.0,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  authService.logOut();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Login()),
                                  );
                                },
                              ),
                            )
                        )
                      ])))
            ])));
  }
}
