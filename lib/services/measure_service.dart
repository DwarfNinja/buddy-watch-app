import 'dart:async';

import 'package:buddywatch_app/models/measure.dart';
import 'package:buddywatch_app/models/measurement_type.dart';
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

  Future<GebruikerStatus> CalculateStatus() async {
    var k = await getFilteredMeasuresOfUser(MeasurementType.heartRate);

      var average= k.reduce((a, b) => a + b) / k.length;
      // for (var task in value as List<int>) {
      //   list.add(task);
      //   // do something
      // }

    // var result = _measureList.map((m) => m['heart_rate']).reduce((a, b) => a + b) / _measureList.length;
    // print(result);
    // print(_measureList);
    print(average);
    if(average < 50) {
      return GebruikerStatus.red;
    }
    if(average > 130) {
      return GebruikerStatus.red;
    }
    if(average < 60 && average > 50) {
      return GebruikerStatus.yellow;
    }
    if(average > 110 && average < 130) {
      return GebruikerStatus.yellow;
    }
    return GebruikerStatus.green;
    //return GebruikerStatus.geel;

  }
}