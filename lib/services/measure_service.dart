import 'dart:async';
import 'dart:math';

import 'package:buddywatch_app/models/measure.dart';
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


  int generateRandomNumber(int min, int max) {
    if (min >= max) {
      throw ArgumentError('Invalid range');
    }

    Random random = Random();
    return min + random.nextInt(max - min + 1);
  }

  Stream<Measure> getLiveMeasureStream() {
    return Stream.periodic(const Duration(seconds: 2), (_) {
      return Measure.base(
          createdAt: DateTime.now(),
          respiratoryRate: generateRandomNumber(0, 30).toDouble(),
          temperature: generateRandomNumber(0, 50).toDouble(),
          heartRate: generateRandomNumber(0, 180).toDouble(),
          oxygenSaturation: generateRandomNumber(0, 100).toDouble(),
      );
    });
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
}