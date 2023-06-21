import 'package:buddywatch_app/color_palette.dart';
import 'package:buddywatch_app/models/measure.dart';
import 'package:buddywatch_app/services/measure_service.dart';
import 'package:buddywatch_app/widgets/thumb_indicator.dart';
import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_native/flutter_rating_native.dart';

class Healthbook extends StatefulWidget {
  const Healthbook({Key? key}) : super(key: key);

  @override
  State<Healthbook> createState() => _HealthbookState();
}

class _HealthbookState extends State<Healthbook> {
  MeasureService measureService = MeasureService();
  late final Stream<Measure> currentMeasureStream;
  late final Future<List<double>> sleepDataFuture;
  final cron = Cron();

  final Map<Indication, String> indicationMessage = {
    Indication.low: "Er zijn geen abnormale waardes gedetecteerd. Geniet van uw dag!",
    Indication.elevated: "Er zijn verhoogde waardes gedetecteerd. Bekijk uw signaleringsplan voor de stappen die u moet ondernemen.",
    Indication.high: "Er zijn hoge waardes gedetecteerd. Wij adviseren dat u zichzelf uit de situatie verwijderd.",
    Indication.critical: "Er zijn kritisch waardes gedetecteerd. Neem zo snel mogelijk contact op met hulpverleners."
  };

  int rating = 0;

  @override
  void initState() {
    currentMeasureStream = measureService.getLiveMeasureStream();
    sleepDataFuture = Future.value(measureService.getSleepingHoursOfPastSevenDays());
    cron.schedule(Schedule.parse('*/1 * * * *'), () async {
      List<Measure> measures = List.from(measureService.measureList);
      print('Original measures length: ${measures.length}');
      await measureService.insertMeasure(measures);
      measureService.measureList.clear();
      print('Inserted measures count: ${measures.length}');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.darkGrey,
      body: FutureBuilder(
        future: sleepDataFuture,
        builder: (context, futureSnapshot) {
          if (futureSnapshot.hasError || futureSnapshot.data == null || futureSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                  strokeWidth: 5,
                  backgroundColor: ColorPalette.darkGrey,
                  color: Colors.white),
            );
          }
          List<double> sleepData = futureSnapshot.data as List<double>;
          return StreamBuilder<Object>(
              stream: currentMeasureStream,
              builder: (context, streamSnapshot) {
                if (streamSnapshot.hasError || streamSnapshot.data == null || streamSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                        strokeWidth: 5,
                        backgroundColor: ColorPalette.darkGrey,
                        color: Colors.white),
                  );
                }
                Measure measure = streamSnapshot.data as Measure;
                Indication indication = measureService.calculateFullStatusIndication(measureService.getHealthIndication(measure, sleepData), rating);
                return SafeArea(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: IconButton(
                                  iconSize: 40,
                                  onPressed: () => Navigator.of(context).pop(),
                                  icon: const Icon(
                                    Icons.arrow_back_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            "Healthbook",
                            style: TextStyle(fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          const Spacer(),
                        ],
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ThumbIndicator(
                                size: 160, iconSize: 80, indication: indication),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Container(
                                constraints: const BoxConstraints(
                                    minHeight: 200
                                ),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20)),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  heightFactor: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Text(
                                      indicationMessage[indication]!,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 25),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(20)),
                                color: Colors.white,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text(
                                  "Hoe voelt u zich?",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 25),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: FlutterRating(
                                rating: rating.toDouble(),
                                starCount: 5,
                                size: 60,
                                onRatingChanged: (value) {
                                  setState(() {
                                    rating = value.toInt();
                                    measureService.insertRating(rating);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
          );
        },
      ),
    );
  }
}
