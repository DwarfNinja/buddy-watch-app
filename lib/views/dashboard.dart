import 'package:buddywatch_app/services/measure_service.dart';
import 'package:buddywatch_app/views/healthbook.dart';
import 'package:buddywatch_app/widgets/thumb_indicator.dart';
import 'package:flutter/material.dart';

import '../models/measurement_type.dart';

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
                  const SizedBox(height: 25),
                  const Column(
                    children:  [
                      Text(
                        'Afgelopen 7 dagen',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: 20),
                      ThumbIndicator(size: 140, iconSize: 65, indication: Indication.low),
                    ],
                  ),
                  const SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const <Widget>[
                      ThumbIndicator(indication: Indication.low, text: "Maandag"),
                      ThumbIndicator(indication: Indication.elevated, text: "Dinsdag"),
                      ThumbIndicator(indication: Indication.elevated, text: "Woensdag"),
                      ThumbIndicator(indication: Indication.low, text: "Donderdag"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const <Widget>[
                        ThumbIndicator(indication: Indication.low, text: "Vrijdag"),
                        ThumbIndicator(indication: Indication.critical, text: "Zaterdag"),
                        ThumbIndicator(indication: Indication.elevated, text: "Zondag"),
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