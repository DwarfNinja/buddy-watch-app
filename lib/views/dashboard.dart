import 'package:buddywatch_app/color_palette.dart';
import 'package:buddywatch_app/views/healthbook.dart';
import 'package:buddywatch_app/views/home.dart';
import 'package:buddywatch_app/widgets/thumb_indicator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late final Future<Indication> _indicationWeek;

  late final Future<Indication> _indicationToday;
  late final DateTime now = DateTime.now();
  late final DateTime today = DateTime(now.year, now.month, now.day);
  String todayFormatted = "Today";

  late final Future<Indication> _indicationYesterday;
  late final DateTime todayNeg1 = today.subtract(const Duration(days: 1));
  late final String todayNeg1Formatted = DateFormat('EEEE').format(todayNeg1);

  late final Future<Indication> _indicationNeg2;
  late final DateTime todayNeg2 = today.subtract(const Duration(days: 2));
  late final String todayNeg2Formatted = DateFormat('EEEE').format(todayNeg2);

  late final Future<Indication> _indicationNeg3;
  late final DateTime todayNeg3 = today.subtract(const Duration(days: 3));
  late final String todayNeg3Formatted = DateFormat('EEEE').format(todayNeg3);

  late final Future<Indication> _indicationNeg4;
  late final DateTime todayNeg4 = today.subtract(const Duration(days: 4));
  late final String todayNeg4Formatted = DateFormat('EEEE').format(todayNeg4);

  late final Future<Indication> _indicationNeg5;
  late final DateTime todayNeg5 = today.subtract(const Duration(days: 5));
  late final String todayNeg5Formatted = DateFormat('EEEE').format(todayNeg5);

  late final Future<Indication> _indicationNeg6;
  late final DateTime todayNeg6 = today.subtract(const Duration(days: 6));
  late final String todayNeg6Formatted = DateFormat('EEEE').format(todayNeg6);

  @override
  void initState() {
    super.initState();
    // measureService.deleteAllData();
    // measureService.insertDummyData();
    _loadIndications();
  }

  Future<void> _loadIndications() async {
    _indicationWeek = measureService.calculateAverageStatusWeek();
    _indicationToday = measureService.calculateStatusDay(today);
    _indicationYesterday = measureService.calculateStatusDay(todayNeg1);
    _indicationNeg2 = measureService.calculateStatusDay(todayNeg2);
    _indicationNeg3 = measureService.calculateStatusDay(todayNeg3);
    _indicationNeg4 = measureService.calculateStatusDay(todayNeg4);
    _indicationNeg5 = measureService.calculateStatusDay(todayNeg5);
    _indicationNeg6 = measureService.calculateStatusDay(todayNeg6);

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
                FutureBuilder<List<dynamic>>(
                  future: Future.wait([_indicationWeek]),
                  builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 5,
                          backgroundColor: ColorPalette.darkGrey,
                          color: Colors.white,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return const Center(
                        child: Text('Error loading data'),
                      );
                    }
                    Indication indicationWeek = snapshot.data![0];
                    return Column(
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
                        ThumbIndicator(size: 140, iconSize: 65, indication: indicationWeek),
                      ],
                    );
                  },
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
                      ),
                    ),
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
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Healthbook()),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                FutureBuilder<List<dynamic>>(
                  future: Future.wait([_indicationToday, _indicationYesterday, _indicationNeg2, _indicationNeg3, _indicationNeg4, _indicationNeg5, _indicationNeg6]),
                  builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 5,
                          backgroundColor: ColorPalette.darkGrey,
                          color: Colors.white,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return const Center(
                        child: Text('Error loading data'),
                      );
                    }
                    Indication indicationToday = snapshot.data![0];
                    Indication indicationYesterday = snapshot.data![1];
                    Indication indicationNeg2 = snapshot.data![2];
                    Indication indicationNeg3 = snapshot.data![3];
                    Indication indicationNeg4 = snapshot.data![4];
                    Indication indicationNeg5 = snapshot.data![5];
                    Indication indicationNeg6 = snapshot.data![6];

                    return Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            ThumbIndicator(indication: indicationNeg6, text: todayNeg6Formatted),
                            ThumbIndicator(indication: indicationNeg5, text: todayNeg5Formatted),
                            ThumbIndicator(indication: indicationNeg4, text: todayNeg4Formatted),
                            ThumbIndicator(indication: indicationNeg3, text: todayNeg3Formatted),
                          ],
                        ),
                        const SizedBox(height: 20), // Add spacing between the two rows
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            ThumbIndicator(indication: indicationNeg2, text: todayNeg2Formatted),
                            ThumbIndicator(indication: indicationYesterday, text: todayNeg1Formatted),
                            ThumbIndicator(indication: indicationToday, text: todayFormatted),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
