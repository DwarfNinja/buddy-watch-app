import 'package:buddywatch_app/healthbook.dart';
import 'package:buddywatch_app/profile.dart';
import 'package:buddywatch_app/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.blueGrey.shade900,
            appBar: AppBar(
              centerTitle: true,
              title: const Text('BuddyWatch'),
              backgroundColor: Colors.black,
            ),
            body: Column(
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(25),
                        //apply padding to all four sides
                        child: Align(
                            alignment: Alignment.center,
                            // Align however you like (i.e .centerRight, centerLeft)
                            child: Text(
                              'Afgelopen 7 dagen',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25),
                        //apply padding to all four sides
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
                                Icons.thumb_up,
                                color: Colors.black,
                                size: 75.0,
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25),
                        //apply padding to all four sides
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                                height: 125.0,
                                width: 125.0,
                                color: Colors.transparent,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  child: const Icon(
                                    Icons.fitness_center,
                                    color: Colors.black,
                                    size: 75.0,
                                  ),
                                )),
                        InkWell(
                          child: Container(
                                height: 125.0,
                                width: 125.0,
                                color: Colors.transparent,

                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  child: const Icon(
                                    Icons.monitor_heart,
                                    color: Colors.black,
                                    size: 75.0,

                                  ),

                                )),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Healthbook()),
                              );
                      },),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        //apply padding to all four sides
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                                height: 70.0,
                                width: 70.0,
                                color: Colors.transparent,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  child: const Icon(
                                    Icons.thumb_down,
                                    color: Colors.black,
                                    size: 30.0,
                                  ),
                                )),
                            Container(
                                height: 70.0,
                                width: 70.0,
                                color: Colors.transparent,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  child: const Icon(
                                    Icons.thumb_up,
                                    color: Colors.black,
                                    size: 30.0,
                                  ),
                                )),
                            Container(
                                height: 70.0,
                                width: 70.0,
                                color: Colors.transparent,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  child: const Icon(
                                    Icons.thumb_up,
                                    color: Colors.black,
                                    size: 30.0,
                                  ),
                                )),
                            Container(
                                height: 70.0,
                                width: 70.0,
                                color: Colors.transparent,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  child: const Icon(
                                    Icons.thumb_up,
                                    color: Colors.black,
                                    size: 30.0,
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        //apply padding to all four sides
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                                height: 70.0,
                                width: 70.0,
                                color: Colors.transparent,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  child: const Icon(
                                    Icons.thumb_up,
                                    color: Colors.black,
                                    size: 30.0,
                                  ),
                                )),
                            Container(
                                height: 70.0,
                                width: 70.0,
                                color: Colors.transparent,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  child: const Icon(
                                    Icons.thumb_down,
                                    color: Colors.black,
                                    size: 30.0,
                                  ),
                                )),
                            Container(
                                height: 70.0,
                                width: 70.0,
                                color: Colors.transparent,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  child: const Icon(
                                    Icons.thumb_up,
                                    color: Colors.black,
                                    size: 30.0,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
              ],
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
                          MaterialPageRoute(builder: (context) => const Dashboard()),
                        );
                      },
                    )
                  ),
                  BottomNavigationBarItem(
                    label: "Profile",
                      icon: IconButton(
                        icon: const Icon(Icons.account_circle),

                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Profile()),
                          );
                        },
                      )
                  ),
                  BottomNavigationBarItem(
                    label: "Settings",
                      icon: IconButton(
                        icon: const Icon(Icons.settings),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Settings()),
                          );
                        },
                      )
                  )
                ],

              ),

              // body: Column(
              //     children: [
              //     Expanded(
              //     child: SingleChildScrollView(
              //     child: Column(
              //     children: [
            )

        )

    );
  }
}
