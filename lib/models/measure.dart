class Measure {
  int measureId;
  DateTime time;
  int respiratoryRate;
  double temperature;
  int heartRate;
  int oxygenSaturation;

  Measure({
    required this.measureId,
    required this.time,
    required this.respiratoryRate,
    required this.temperature,
    required this.heartRate,
    required this.oxygenSaturation,
  });

  factory Measure.fromJson(Map<String, dynamic> json) {
    return Measure(
      measureId: json['measure_id'],
      time: DateTime.parse(json['time']),
      respiratoryRate: json['respiratory_rate'],
      temperature: json['temperature'].toDouble(),
      heartRate: json['heart_rate'],
      oxygenSaturation: json['oxygen_saturation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'measure_id': measureId,
      'time': time.toIso8601String(),
      'respiratory_rate': respiratoryRate,
      'temperature': temperature,
      'heart_rate': heartRate,
      'oxygen_saturation': oxygenSaturation,
    };
  }
}
