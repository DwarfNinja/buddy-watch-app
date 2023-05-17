import 'package:buddywatch_app/login.dart';
import 'package:buddywatch_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {

  const Profile({Key? key})
      : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('BuddyWatch'),
            backgroundColor: Colors.black,
          ),
        )
    );
  }
}