import 'dart:async';

import 'package:buddywatch_app/models/measure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MeasureService {
  final supabase = Supabase.instance.client;

  Future<List<Measure>> getAllMeasuresOfUser() async {
    final measureListResponse = await supabase
        .from('measures')
        .select('*')
        .eq('user_id', supabase.auth.currentUser!.id);

    List<Measure> measureList = [];
    measureListResponse.forEach((measure) => measureList.add(Measure.fromJson(measure)));

    return measureList;
  }

  Future<Measure> getMeasureById(id) async {
    final measureListResponse = await supabase
        .from('measures')
        .select('*')
        .eq('id', id);

    Measure measure = Measure.fromJson(measureListResponse);

    return measure;
  }
}