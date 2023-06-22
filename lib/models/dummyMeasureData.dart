import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import 'measure.dart';
final _supabase = Supabase.instance.client;
const uuid = Uuid();
List<Measure> dummyDataLastWeek = [
  Measure.base(
    id: uuid.v1(),
    userId: _supabase.auth.currentUser!.id,
    createdAt: DateTime.now().subtract(const Duration(days: 6)),
    respiratoryRate: 3,
    temperature: 50,
    heartRate: 10,
    oxygenSaturation: 0,
  ),
  Measure.base(
    id: uuid.v1(),
    userId: _supabase.auth.currentUser!.id,
    createdAt: DateTime.now().subtract(const Duration(days: 5)),
    respiratoryRate: 8.8,
    temperature: 50,
    heartRate: 70,
    oxygenSaturation: 90,
  ),
  Measure.base(
    id: uuid.v1(),
    userId: _supabase.auth.currentUser!.id,
    createdAt: DateTime.now().subtract(const Duration(days: 4)),
    respiratoryRate: 8.8,
    temperature: 50,
    heartRate: 70,
    oxygenSaturation: 90,
  ),
  Measure.base(
    id: uuid.v1(),
    userId: _supabase.auth.currentUser!.id,
    createdAt: DateTime.now().subtract(const Duration(days: 3)),
    respiratoryRate: 10,
    temperature: 37.2,
    heartRate: 90,
    oxygenSaturation: 96.2,
  ),
  Measure.base(
    id: uuid.v1(),
    userId: _supabase.auth.currentUser!.id,
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    respiratoryRate: 8.8,
    temperature: 32.2,
    heartRate: 113.8,
    oxygenSaturation: 94.9,
  ),
  Measure.base(
    id: uuid.v1(),
    userId: _supabase.auth.currentUser!.id,
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    respiratoryRate: 10,
    temperature: 37.2,
    heartRate: 90,
    oxygenSaturation: 96.2,
  ),
  Measure.base(
    id: uuid.v1(),
    userId: _supabase.auth.currentUser!.id,
    createdAt: DateTime.now(),
    respiratoryRate: 10,
    temperature: 37.2,
    heartRate: 90,
    oxygenSaturation: 96.2,
  ),
];