import 'dart:async';

import 'package:buddywatch_app/models/measure.dart';
import 'package:buddywatch_app/models/measurement_type.dart';
import 'package:buddywatch_app/widgets/thumb_indicator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
enum GebruikerStatus {
  red,
  yellow,
  green,

}
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
    // measureListResponse.forEach((measure) => measureList.add(double.parse([measurementType.value].toString())));

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

  Future<Indication> calculateStatus() async {
    List<double> filteredMeasureDataList = await getFilteredMeasuresOfUser(MeasurementType.heartRate);

    double average= filteredMeasureDataList.reduce((a, b) => a + b) / filteredMeasureDataList.length;

    if(average < 50) {
      return Indication.negative;
    }
    if(average > 130) {
      return Indication.negative;
    }
    if(average < 60 && average > 50) {
      return Indication.warning;
    }
    if(average > 110 && average < 130) {
      return Indication.warning;
    }
    return Indication.positive;
  }
}