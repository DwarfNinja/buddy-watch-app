import 'dart:async';
import 'dart:math';

import 'package:buddywatch_app/models/dummyMeasureData.dart';
import 'package:buddywatch_app/models/measure.dart';
import 'package:buddywatch_app/models/measureDTO.dart';

import 'package:buddywatch_app/models/measureDTO.dart';
import 'package:buddywatch_app/models/measurement_type.dart';
import 'package:buddywatch_app/widgets/thumb_indicator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class MeasureService {
  final _supabase = Supabase.instance.client;

  Future<List<Measure>> getAllMeasuresOfUser() async {
    final measureListResponse = await _supabase
        .from('measures')
        .select('*')
        .eq('user_id', _supabase.auth.currentUser!.id);

    List<Measure> measureList = [];
    measureListResponse.forEach((measure) => measureList.add(Measure.fromJson(measure)));

    return measureList;
  }

  Future<List<double>> getFilteredMeasuresOfUser(MeasurementType measurementType) async {
    final measureListResponse = await _supabase
        .from('measures')
        .select(measurementType.value!)
        .eq('user_id', _supabase.auth.currentUser!.id);

    List<double> measureList = [];
    measureListResponse.forEach((measure) => measureList.add((measure[measurementType.value] as int).toDouble()));

    return measureList;
  }

  Future<Measure> getMeasureById(id) async {
    final measureListResponse = await _supabase
        .from('measures')
        .select('*')
        .eq('id', id);

    Measure measure = Measure.fromJson(measureListResponse);

    return measure;
  }


  void insertDummyData() async {
    for(MeasureDTO measureDto in MeasureDTO.dummyData()) {
      await _supabase.from('measures').insert(measureDto).select();
    }
  }

  void insertRating(int rating) async {

    await _supabase
        .from('profiles')
        .update({'rating': rating})
        .eq('id', _supabase.auth.currentUser!.id)
        .select();
  }

  void deleteAllData() async {
    await _supabase.from('measures').delete().eq('user_id', _supabase.auth.currentUser!.id);
  }

  Future<List<Measure>> getMeasuresFromDate (DateTime dateTime) async {
    final response = await _supabase
        .from('measures')
        .select('*')
        .eq('created_at', dateTime)
        .eq('user_id', _supabase.auth.currentUser!.id);

    List<Measure> measureList = [];
    response.forEach((measure) => measureList.add(Measure.fromJson(measure)));
    return measureList;
  }

  List<Measure> filterMeasuresByDateTime(DateTime dateTime) {
    List<Measure> measures = dummyDataLastWeek;
    return measures.where((measure) {
      // Compare the date part of the createdAt DateTime with the given dateTime
      return measure.createdAt.year == dateTime.year &&
          measure.createdAt.month == dateTime.month &&
          measure.createdAt.day == dateTime.day;
    }).toList();
  }

  Future<Indication> calculateStatusDay(DateTime day) async {
    List<Measure> measureList = filterMeasuresByDateTime(day);
    int sum = 0;

    for (Measure measure in measureList) {
      sum += calculateStatus(measure).index;
    }
    print(sum);
    int averageIndex = sum ~/ measureList.length;
    Indication averageIndication = Indication.values[averageIndex];

    return averageIndication;
  }

  Future<Indication> calculateAverageStatusWeek() async {
    List<Measure> measureList = dummyDataLastWeek;
    int sum = 0;

    for (Measure measure in measureList) {
      sum += calculateStatus(measure).index;
    }
    int averageIndex = sum ~/ measureList.length;
    Indication averageIndication = Indication.values[averageIndex];

    return averageIndication;
  }

  int generateRandomNumber(int min, int max) {
    if (min >= max) {
      throw ArgumentError('Invalid range');
    }

    Random random = Random();
    return min + random.nextInt(max - min + 1);
  }

  Stream<Measure> getLiveMeasureStream() {
    return Stream.periodic(const Duration(seconds: 2), (_) {
      return getRandomMeasure();
    });
  }

  Measure getRandomMeasure() {
      return Measure.base(
        createdAt: DateTime.now(),
        respiratoryRate: generateRandomNumber(0, 30).toDouble(),
        temperature: generateRandomNumber(0, 50).toDouble(),
        heartRate: generateRandomNumber(0, 180).toDouble(),
        oxygenSaturation: generateRandomNumber(0, 100).toDouble(),
      );
  }

  Measure getRandomMeasureWithDate(DateTime dateTime) {
    return Measure.base(
      createdAt: dateTime,
      respiratoryRate: generateRandomNumber(0, 30).toDouble(),
      temperature: generateRandomNumber(0, 50).toDouble(),
      heartRate: generateRandomNumber(0, 180).toDouble(),
      oxygenSaturation: generateRandomNumber(0, 100).toDouble(),
    );
  }

  Indication calculateStatus(Measure measure) {
    Indication respiratoryRateStatus = getOxygenSaturationStatus(measure.respiratoryRate);
    Indication temperatureStatus = getTemperatureStatus(measure.temperature);
    Indication heartRateStatus = getHeartRateStatus(measure.heartRate);
    Indication oxygenSaturationStatus = getOxygenSaturationStatus(measure.oxygenSaturation);

    Indication averageIndication = Indication.values[(respiratoryRateStatus.index +
        temperatureStatus.index + heartRateStatus.index + oxygenSaturationStatus.index) ~/ 4];

    return averageIndication;
  }

  Indication getRespiratoryRateStatus(double respiratoryRate) {
    if(respiratoryRate >= 15 && respiratoryRate <= 20) {
      return Indication.elevated;
    }
    else if((respiratoryRate < 9) || (respiratoryRate >= 21 && respiratoryRate <= 30)) {
      return Indication.high;
    }
    else if(respiratoryRate > 30) {
      return Indication.critical;
    }
    return Indication.low;
  }

  Indication getTemperatureStatus(double temperature) {
    if((temperature >= 35.1 && temperature <= 36.5)) {
      return Indication.elevated;
    }
    else if(temperature < 35.1 || temperature > 39) {
      return Indication.critical;
    }
    else if(temperature >= 37.5 && temperature <= 39) {
      return Indication.high;
    }
    return Indication.low;
  }


  Indication getHeartRateStatus(double heartRate) {
    if(heartRate >= 40 && heartRate <= 51) {
      return Indication.elevated;
    }
    else if((heartRate < 40 && heartRate >= 35) || (heartRate >= 111 && heartRate <= 130)) {
      return Indication.high;
    }
    else if(heartRate > 130 || heartRate < 35) {
      return Indication.critical;
    }
    return Indication.low;
  }

  Indication getOxygenSaturationStatus(double oxygenSaturation) {
    if(oxygenSaturation < 90) {
      return Indication.critical;
    }
    return Indication.low;
  }
}