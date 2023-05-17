import 'package:buddywatch_app/views/healthbook.dart';
import 'package:buddywatch_app/widgets/thumb_indicator.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(25),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Afgelopen 7 dagen',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(25),
                    //apply padding to all four sides
                    child: ThumbIndicator(size: 140, iconSize: 65, indication: Indication.warning)
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25),
                    //apply padding to all four sides
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SizedBox(
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
                                Icons.fitness_center_rounded,
                                color: Colors.black,
                                size: 90,
                              ),
                            )),
                        GestureDetector(
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
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const <Widget>[
                      ThumbIndicator(indication: Indication.positive),
                      ThumbIndicator(indication: Indication.warning),
                      ThumbIndicator(indication: Indication.warning),
                      ThumbIndicator(indication: Indication.positive),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const <Widget>[
                        ThumbIndicator(indication: Indication.positive),
                        ThumbIndicator(indication: Indication.negative),
                        ThumbIndicator(indication: Indication.warning),
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}