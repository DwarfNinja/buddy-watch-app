import 'package:buddywatch_app/color_palette.dart';
import 'package:buddywatch_app/services/auth_service.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

AuthService authService = AuthService();

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.darkGrey,
      body: SafeArea(
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Text(
                  "Settings",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Colors.white),
                ),
                Spacer(),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: GestureDetector(
                      child: SizedBox(
                          height: 125,
                          width: 125,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                            ),
                            child: const Icon(
                              Icons.logout_rounded,
                              color: Colors.black,
                              size: 90,
                            ),
                          )),
                      onTap: () {
                        authService.logOut();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
