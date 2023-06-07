import 'dart:async';
import 'dart:async';

import 'package:buddywatch_app/models/measure.dart';
import 'package:buddywatch_app/models/measurement_type.dart';
import 'package:buddywatch_app/widgets/thumb_indicator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/measureDTO.dart';
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


  void insertDummyData() async {
    for(var v in MeasureDTO.dummyData()) {
      await _supabase.from('measures').insert(v).select();
    }
  }

  void insertRating(int rating) async {

    await _supabase.from('profiles').insert({'rating': rating}).eq('user_id', _supabase.auth.currentUser!.id).select();
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

  Future<Indication> calculateyesterday() async {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    // List<dynamic> list = [];
    // getMeasuresFromDate(today).then((value) => list.add(value));

    List<double> filteredMeasureDataList = await getMeasuresFromDateAndType(today, MeasurementType.heartRate);
    double average = filteredMeasureDataList.reduce((a, b) => a + b) / filteredMeasureDataList.length;

    return Indication.positive;
  }

  Future<double> calculateAverage(MeasurementType measurementType) async {
    List<double> filteredMeasureDataList = await getFilteredMeasuresOfUser(measurementType);

    double heartRate = filteredMeasureDataList.reduce((a, b) => a + b) / filteredMeasureDataList.length;
    return heartRate;
  }

  Future<Indication> calculateStatus() async {
    // List<double> filteredMeasureDataList = await getFilteredMeasuresOfUser(MeasurementType.heartRate);
    // double heartRate = filteredMeasureDataList.reduce((a, b) => a + b) / filteredMeasureDataList.length;
    List<Indication> averageIndications = [];
    double heartRate =await calculateAverage(MeasurementType.heartRate);
    double oxygen = await calculateAverage(MeasurementType.oxygenSaturation);


    if((heartRate > 40 && heartRate < 51) || (heartRate > 101 && heartRate < 110)) {
      return Indication.warning;
    }
    if((heartRate < 40) || (heartRate > 111)) {
      return Indication.negative;
    }

    return Indication.positive;
  }


  //   List<Measure> yesterday = [];
  //   await getAllMeasuresOfUser().then((value) => {
  //   for(var a in value) {
  //     if(a.createdAt == DateTime.now().subtract(const Duration(days: 1))) {
  //       yesterday.add(value as Measure)
  //     }
  //   }});
  //   return Indication.positive;
  //
  // }


  // Future<Indication> calculateStatus() async {
  //   List<double> filteredMeasureDataList = await getFilteredMeasuresOfUser(MeasurementType.heartRate);
  //
  //   double average= filteredMeasureDataList.reduce((a, b) => a + b) / filteredMeasureDataList.length;
  //
  //   if(average < 50) {
  //     return Indication.negative;
  //   }
  //   if(average > 130) {
  //     return Indication.negative;
  //   }
  //   if(average < 60 && average > 50) {
  //     return Indication.warning;
  //   }
  //   if(average > 110 && average < 130) {
  //     return Indication.warning;
  //   }
  //   return Indication.positive;
  // }
}