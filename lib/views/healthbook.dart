import 'package:buddywatch_app/color_palette.dart';
import 'package:buddywatch_app/views/dashboard.dart';
import 'package:buddywatch_app/widgets/thumb_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_native/flutter_rating_native.dart';

class Healthbook extends StatefulWidget {
  const Healthbook({Key? key}) : super(key: key);

  @override
  State<Healthbook> createState() => _HealthbookState();
}

class _HealthbookState extends State<Healthbook> {
  int rating = 3;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: ColorPalette.darkGrey,
          body: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                          "Profile",
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                        const Spacer(),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const ThumbIndicator(size: 160, iconSize: 80, indication: Indication.warning),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
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
                        rating: rating.toDouble(),
                        starCount: 5,
                        size: 60,
                        onRatingChanged: (value) {
                          setState(() {
                            rating = value.toInt();
                            print(rating);
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
      ),
    );
  }
}
