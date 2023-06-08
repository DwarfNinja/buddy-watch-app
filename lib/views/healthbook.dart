import 'package:buddywatch_app/color_palette.dart';
import 'package:buddywatch_app/models/measure.dart';
import 'package:buddywatch_app/services/measure_service.dart';
import 'package:buddywatch_app/widgets/thumb_indicator.dart';
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

  int rating = 3;

  Map<Indication, String> indicationMessage = {
    Indication.low: "Er zijn geen abnormale waardes gedetecteerd.",
    Indication.elevated: "Er zijn milde waardes gedetecteerd. Wij adviseren dat u zichzelf uit deze situatie haalt.",
    Indication.high: "Er zijn hoge waardes gedecteerd. Bekijk uw terugvalplan voor de stappen die u moet ondernemen.",
    Indication.critical: "Er zijn waardse gedecteerd met een kritisch niveau. Neem zo snel mogelijk contact op met hulpverleners."
  };

  @override
  void initState() {
    currentMeasureStream = measureService.getLiveMeasureStream();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.darkGrey,
      body: StreamBuilder<Object>(
          stream: currentMeasureStream,
          builder: (context, snapshot) {
            if (snapshot.hasError || snapshot.data == null || snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                    strokeWidth: 5,
                    backgroundColor: ColorPalette.darkGrey,
                    color: Colors.white),
              );
            }
            Measure measure = snapshot.data as Measure;
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
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Colors.white),
                      ),
                      const Spacer(),
                    ],
                  ),
                  Expanded(
                    flex: 2,
                      child: ThumbIndicator(size: 160, iconSize: 80, indication: measureService.calculateStatus(measure))),
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 20),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              indicationMessage[measureService.calculateStatus(measure)]!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
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
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
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
                  ),
                ],
              ),
            );
          }
      ),
    );
  }
}
