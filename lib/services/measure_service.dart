import 'dart:async';

import 'package:buddywatch_app/models/measure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MeasureService {
  final supabase = Supabase.instance.client;

  Future<List<Measure>> getAllMeasures() async {
    final measureListResponse = await supabase
        .from('Measure')
        .select('*');

    List<Measure> measureList = [];
    measureListResponse.forEach((measure) => measureList.add(Measure.fromJson(measure)));

    return measureList;
  }

  Future<Measure> getMeasureById(id) async {
    final measureListResponse = await supabase
        .from('Measure')
        .select('*')
        .eq('measure_id', id);

    Measure measure = Measure.fromJson(measureListResponse);

    return measure;
  }
}