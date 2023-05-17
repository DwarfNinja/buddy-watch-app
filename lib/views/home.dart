import 'package:buddywatch_app/color_palette.dart';
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
            backgroundColor: ColorPalette.darkGrey,
            body: IndexedStack(
              index: currentIndex,
              children: pages,
            ),
            bottomNavigationBar: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(15),
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                unselectedItemColor: Colors.black,
                selectedItemColor: Colors.black,
                unselectedFontSize: 15,
                selectedFontSize: 15,
                onTap: (index) => setState(() => currentIndex = index),
                items: const [
                  BottomNavigationBarItem(
                      label: "Home",
                      icon: Icon(Icons.home_rounded, size: 35),
                  ),
                  BottomNavigationBarItem(
                      label: "Profile",
                      icon: Icon(Icons.account_circle_rounded, size: 35),
                  ),
                  BottomNavigationBarItem(
                      label: "Settings",
                      icon: Icon(Icons.settings_rounded, size: 35),
                      )
                ],
              ),
            )
        )
    );
  }
}
