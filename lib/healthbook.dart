import 'package:buddywatch_app/profile.dart';
import 'package:buddywatch_app/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_native/flutter_rating_native.dart';

import 'dashboard.dart';

class Healthbook extends StatefulWidget {
  const Healthbook({Key? key}) : super(key: key);

  @override
  State<Healthbook> createState() => _HealthbookState();
}

class _HealthbookState extends State<Healthbook> {
  double rating = 3;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.blueGrey.shade900,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: AppBar(
                    centerTitle: true,
                    title: const Text('BuddyWatch'),
                    backgroundColor: Colors.black,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 50.0, left: 20.0, bottom: 20.0, right: 20.0),
                  child: Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        'Vandaag',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          height: 150.0,
                          width: 150.0,
                          color: Colors.transparent,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            child: const Icon(
                              Icons.thumb_up,
                              color: Colors.black,
                              size: 75.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.white,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                "Er zijn geen symptomen gedetecteerd. Geniet van uw dag.",
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 0.0, right: 0.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.white,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                "Hoe voelt u zich?",
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: FlutterRating(
                            rating: rating,
                            starCount: 5,
                            size: 60,
                            onRatingChanged: (value) {
                              setState(() {
                                print(value);
                                rating = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              // sets the background color of the `BottomNavigationBar`

              canvasColor: Colors.black,
            ),
            child: BottomNavigationBar(
              unselectedItemColor: Colors.white,
              selectedItemColor: Colors.white,
              items: [
                BottomNavigationBarItem(
                    label: "Home",
                    icon: IconButton(
                      icon: const Icon(Icons.home),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Dashboard()),
                        );
                      },
                    )),
                BottomNavigationBarItem(
                    label: "Profile",
                    icon: IconButton(
                      icon: const Icon(Icons.account_circle),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Profile()),
                        );
                      },
                    )),
                BottomNavigationBarItem(
                    label: "Settings",
                    icon: IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Settings()),
                        );
                      },
                    ))
              ],
            ),

            // body: Column(
            //     children: [
            //     Expanded(
            //     child: SingleChildScrollView(
            //     child: Column(
            //     children: [
          )),
    );
  }
}