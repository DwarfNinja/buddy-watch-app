import 'dart:async';
import 'dart:math';

import 'package:buddywatch_app/models/measure.dart';
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

  Future<List<double>> getMeasuresFromDateAndType (DateTime dateTime, MeasurementType measurementType) async {
    final response = await _supabase
        .from('measures')
        .select(measurementType.value!)
        .eq('created_at', dateTime)
        .eq('user_id', _supabase.auth.currentUser!.id);

    List<double> measureList = [];
    response.forEach((measure) => measureList.add((measure[measurementType.value] as int).toDouble()));
    return measureList;
  }


  int generateRandomNumber(int min, int max) {
    if (min >= max) {
      throw ArgumentError('Invalid range');
    }

    Random random = Random();
    return min + random.nextInt(max - min + 1);
  }

  Stream<Measure> getLiveMeasureStream(bool callback) async* {
    if (callback) {
      yield getRandomMeasure(); // Emit the initial callback value
    }

    while (true) {
      await Future.delayed(const Duration(seconds: 180));
      yield getRandomMeasure(); // Emit the periodic measure
    }
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

  List<double> getSleepingHoursOfPastSevenDays() {
    return [
      generateRandomNumber(1, 10).toDouble(),
      generateRandomNumber(1, 10).toDouble(),
      generateRandomNumber(1, 10).toDouble(),
      generateRandomNumber(1, 10).toDouble(),
      generateRandomNumber(1, 10).toDouble(),
      generateRandomNumber(1, 10).toDouble(),
      generateRandomNumber(1, 10).toDouble(),
    ];
  }

  Indication getHealthIndication(Measure measure, List<double> sleepData) {
    measure = Measure.base(createdAt: DateTime.now(), respiratoryRate: 0.0, temperature: 40.0, heartRate: 3.0, oxygenSaturation: 0.0);

    Indication respiratoryRateStatus = getRespiratoryRateStatus(measure.respiratoryRate);
    Indication temperatureStatus = getTemperatureStatus(measure.temperature);
    Indication heartRateStatus = getHeartRateStatus(measure.heartRate);
    Indication oxygenSaturationStatus = getOxygenSaturationStatus(measure.oxygenSaturation);
    Indication sleepStatus = getSleepStatus(sleepData);

    print("respiratory_rate: ${respiratoryRateStatus} temperature: ${temperatureStatus} heart_rate: "
        "${heartRateStatus} oxygen_saturation: ${oxygenSaturationStatus} sleep_status ${sleepStatus}");

    Indication averageHealthIndication = Indication.values[(respiratoryRateStatus.index +
        temperatureStatus.index + heartRateStatus.index + oxygenSaturationStatus.index + sleepStatus.index) ~/ 5];

    return averageHealthIndication;
  }

  Indication calculateFullStatusIndication(Indication indication, int rating) {
    int ratingModifier = getRatingIndicationModifier(rating);

    int computedIndication;

    if (indication.index == 0) {
      computedIndication = (indication.index + ratingModifier).clamp(0, Indication.values.length - 1);
    }
    else {
      computedIndication = (indication.index + ratingModifier).clamp(1, Indication.values.length - 1);
    }

    return Indication.values[computedIndication];
  }

  int getRatingIndicationModifier(int rating) {
    if (rating == 0 || rating >= 3 && rating <= 4) {
      return 0;
    }
    else if (rating >= 1 && rating <= 2) {
      return 1;
    }
    else {
      return -1;
    }
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
    if((temperature >= 35.1 && temperature <= 36.5) || temperature > 37.5) {
      return Indication.elevated;
    }
    else if(temperature < 35.1) {
      return Indication.high;
    }
    return Indication.low;
  }


  Indication getHeartRateStatus(double heartRate) {
    if(heartRate >= 40 && heartRate <= 51) {
      return Indication.elevated;
    }
    else if((heartRate < 40) || (heartRate >= 111 && heartRate <= 130)) {
      return Indication.high;
    }
    else if(heartRate > 130) {
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

  Indication getSleepStatus(List<double> sleepHoursList) {
    if (areElementsWithinMax(sleepHoursList, 6, 7)) {
      return Indication.critical;
    }
    else if (areElementsWithinMax(sleepHoursList, 4, 7)) {
      return Indication.high;
    }
    else if (areElementsWithinMax(sleepHoursList, 2, 7)) {
      return Indication.elevated;
    }
    return Indication.low;
  }

  bool areElementsWithinMax(List<double> list, int elementIndex, int max) {
    for (int element = 0; element < elementIndex - 1; element++) {
      if (list[element] > max) {
        return false;
      }
    }
    return true;
  }
}