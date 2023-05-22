import 'dart:async';

import 'package:buddywatch_app/models/measure.dart';
import 'package:buddywatch_app/models/measurement_type.dart';
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
    measureListResponse.forEach((measure) => measureList.add(measure));

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
}