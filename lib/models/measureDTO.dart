
import 'package:supabase_flutter/supabase_flutter.dart';

class MeasureDTO {

  static final SupabaseClient _supabase = Supabase.instance.client;

  String userId;
  DateTime createdAt;
  double respiratoryRate;
  double temperature;
  double heartRate;
  double oxygenSaturation;

  MeasureDTO({
    required this.userId,
    required this.createdAt,
    required this.respiratoryRate,
    required this.temperature,
    required this.heartRate,
    required this.oxygenSaturation,
  });

  factory MeasureDTO.fromJson(Map<String, dynamic> json) {
    return MeasureDTO(
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
      respiratoryRate: json['respiratory_rate'],
      temperature: json['temperature'],
      heartRate: json['heart_rate'],
      oxygenSaturation: json['oxygen_saturation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
      'respiratory_rate': respiratoryRate,
      'temperature': temperature,
      'heart_rate': heartRate,
      'oxygen_saturation': oxygenSaturation,
    };
  }

  static List<MeasureDTO> dummyData() {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime today_neg1 = today.subtract(const Duration(days: 1));
    DateTime today_neg2 = today.subtract(const Duration(days: 2));
    DateTime today_neg3 = today.subtract(const Duration(days: 3));
    DateTime today_neg4 = today.subtract(const Duration(days: 4));
    DateTime today_neg5 = today.subtract(const Duration(days: 5));
    DateTime today_neg6 = today.subtract(const Duration(days: 6));
    List<MeasureDTO> measures = [];
    var measureVandaag1 = MeasureDTO(
        userId: _supabase.auth.currentUser!.id,
        createdAt: today,
        respiratoryRate: 15,
        temperature: 38,
        heartRate: 88,
        oxygenSaturation: 50);

    var measureVandaag2 = MeasureDTO(
        userId: _supabase.auth.currentUser!.id,
        createdAt: today,
        respiratoryRate: 15,
        temperature: 38,
        heartRate: 88,
        oxygenSaturation: 50);

    var measureVandaag3 = MeasureDTO(
        userId: _supabase.auth.currentUser!.id,
        createdAt: today,
        respiratoryRate: 15,
        temperature: 38,
        heartRate: 88,
        oxygenSaturation: 50);
    measures.add(measureVandaag1);
    measures.add(measureVandaag2);
    measures.add(measureVandaag3);
    var measureNeg1_1 = MeasureDTO(
        userId: _supabase.auth.currentUser!.id,
        createdAt: today_neg1,
        respiratoryRate: 154,
        temperature: 386,
        heartRate: 886,
        oxygenSaturation: 505);

    var measureNeg1_2 = MeasureDTO(
        userId: _supabase.auth.currentUser!.id,
        createdAt: today_neg1,
        respiratoryRate: 156,
        temperature: 386,
        heartRate: 886,
        oxygenSaturation: 506);

    var measureNeg1_3 = MeasureDTO(
        userId: _supabase.auth.currentUser!.id,
        createdAt: today_neg1,
        respiratoryRate: 159,
        temperature: 389,
        heartRate: 889,
        oxygenSaturation: 509);

    measures.add(measureNeg1_1);
    measures.add(measureNeg1_2);
    measures.add(measureNeg1_3);

    var measureNeg2_1 = MeasureDTO(
        userId: _supabase.auth.currentUser!.id,
        createdAt: today_neg2,
        respiratoryRate: 10,
        temperature: 37,
        heartRate: 110,
        oxygenSaturation: 60);

    var measureNeg2_2 = MeasureDTO(
        userId: _supabase.auth.currentUser!.id,
        createdAt: today_neg2,
        respiratoryRate: 11,
        temperature: 37,
        heartRate: 111,
        oxygenSaturation: 59);

    var measureNeg2_3 = MeasureDTO(
        userId: _supabase.auth.currentUser!.id,
        createdAt: today_neg2,
        respiratoryRate: 12,
        temperature: 38,
        heartRate: 112,
        oxygenSaturation: 66);
    measures.add(measureNeg2_1);
    measures.add(measureNeg2_2);
    measures.add(measureNeg2_3);

    var measureNeg3_1 = MeasureDTO(
        userId: _supabase.auth.currentUser!.id,
        createdAt: today_neg3,
        respiratoryRate: 6,
        temperature: 34,
        heartRate: 77,
        oxygenSaturation: 40);

    var measureNeg3_2 = MeasureDTO(
        userId: _supabase.auth.currentUser!.id,
        createdAt:today_neg3,
        respiratoryRate: 8,
        temperature: 36,
        heartRate: 88,
        oxygenSaturation: 47);

    var measureNeg3_3 = MeasureDTO(
        userId: _supabase.auth.currentUser!.id,
        createdAt: today_neg3,
        respiratoryRate: 12,
        temperature: 38,
        heartRate: 112,
        oxygenSaturation: 66);
    measures.add(measureNeg3_1);
    measures.add(measureNeg3_2);
    measures.add(measureNeg3_3);

    var measureNeg4_1 = MeasureDTO(
        userId: _supabase.auth.currentUser!.id,
        createdAt: today_neg4,
        respiratoryRate: 154,
        temperature: 386,
        heartRate: 886,
        oxygenSaturation: 505);

    var measureNeg4_2 = MeasureDTO(
        userId: _supabase.auth.currentUser!.id,
        createdAt: today_neg4,
        respiratoryRate: 156,
        temperature: 386,
        heartRate: 886,
        oxygenSaturation: 506);

    var measureNeg4_3 = MeasureDTO(
        userId: _supabase.auth.currentUser!.id,
        createdAt: today_neg4,
        respiratoryRate: 159,
        temperature: 389,
        heartRate: 889,
        oxygenSaturation: 509);

    measures.add(measureNeg4_1);
    measures.add(measureNeg4_2);
    measures.add(measureNeg4_3);

    var measureNeg5_1 = MeasureDTO(
        userId: _supabase.auth.currentUser!.id,
        createdAt: today_neg5,
        respiratoryRate: 10,
        temperature: 37,
        heartRate: 110,
        oxygenSaturation: 60);

    var measureNeg5_2 = MeasureDTO(
        userId: _supabase.auth.currentUser!.id,
        createdAt: today_neg5,
        respiratoryRate: 11,
        temperature: 37,
        heartRate: 111,
        oxygenSaturation: 59);

    var measureNeg5_3 = MeasureDTO(
        userId: _supabase.auth.currentUser!.id,
        createdAt: today_neg5,
        respiratoryRate: 12,
        temperature: 38,
        heartRate: 112,
        oxygenSaturation: 66);
    measures.add(measureNeg5_1);
    measures.add(measureNeg5_2);
    measures.add(measureNeg5_3);

    var measureNeg6_1 = MeasureDTO(
        userId: _supabase.auth.currentUser!.id,
        createdAt: today_neg6,
        respiratoryRate: 6,
        temperature: 34,
        heartRate: 77,
        oxygenSaturation: 40);

    var measureNeg6_2 = MeasureDTO(
        userId: _supabase.auth.currentUser!.id,
        createdAt:today_neg6,
        respiratoryRate: 8,
        temperature: 36,
        heartRate: 88,
        oxygenSaturation: 47);

    var measureNeg6_3 = MeasureDTO(
        userId: _supabase.auth.currentUser!.id,
        createdAt: today_neg6,
        respiratoryRate: 12,
        temperature: 38,
        heartRate: 112,
        oxygenSaturation: 66);
    measures.add(measureNeg6_1);
    measures.add(measureNeg6_2);
    measures.add(measureNeg6_3);



    return measures;
    }
}