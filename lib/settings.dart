import 'package:buddywatch_app/color_palette.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {

  const Settings({Key? key})
      : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorPalette.darkGrey,
      body: Center(
        child: Text(
          "Settings",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
    );
  }
}