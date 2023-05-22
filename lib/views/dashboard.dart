import 'package:buddywatch_app/services/measure_service.dart';
import 'package:buddywatch_app/views/healthbook.dart';
import 'package:buddywatch_app/widgets/thumb_indicator.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}
MeasureService measureService = MeasureService();
var _customIndication = Indication.warning;
class _DashboardState extends State<Dashboard> {

  updateIcon() async {
    GebruikerStatus gebruikerStatus = await measureService.CalculateStatus();
// Here you can write your code
    print(gebruikerStatus);
    setState(() {
      switch (gebruikerStatus) {
        case GebruikerStatus.green:
          setState(() {
            _customIndication = Indication.positive;
          });
          break;
        case GebruikerStatus.yellow:
          setState(() {
            _customIndication = Indication.warning;
          });
          break;
        case GebruikerStatus.red:
          setState(() {
            _customIndication = Indication.negative;
          });
          break;
      }
    });
  }

  @override
  initState()  {
    Future.delayed(const Duration(milliseconds: 500), () {
      updateIcon();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  Column(
                    children:  [
                      const Text(
                        'Afgelopen 7 dagen',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ThumbIndicator(size: 140, iconSize: 65, indication: _customIndication,
                      ),
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
                      ThumbIndicator(indication: Indication.positive, text: "Maandag"),
                      ThumbIndicator(indication: Indication.warning, text: "Dinsdag"),
                      ThumbIndicator(indication: Indication.warning, text: "Woensdag"),
                      ThumbIndicator(indication: Indication.positive, text: "Donderdag"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const <Widget>[
                        ThumbIndicator(indication: Indication.positive, text: "Vrijdag"),
                        ThumbIndicator(indication: Indication.negative, text: "Zaterdag"),
                        ThumbIndicator(indication: Indication.warning, text: "Zondag"),
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