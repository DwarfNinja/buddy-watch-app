import 'package:buddywatch_app/profile.dart';
import 'package:buddywatch_app/settings.dart';
import 'package:buddywatch_app/views/dashboard.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  final pages = [
    const Dashboard(),
    const Profile(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.blueGrey.shade900,
            body: IndexedStack(
              index: currentIndex,
              children: pages,
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.black,
              unselectedItemColor: Colors.white,
              selectedItemColor: Colors.white,
              onTap: (index) => setState(() => currentIndex = index),
              items: const [
                BottomNavigationBarItem(
                    label: "Home",
                    icon: Icon(Icons.home),
                ),
                BottomNavigationBarItem(
                    label: "Profile",
                    icon: Icon(Icons.account_circle),
                ),
                BottomNavigationBarItem(
                    label: "Settings",
                    icon: Icon(Icons.settings),
                    )
              ],
            )
        )
    );
  }
}
