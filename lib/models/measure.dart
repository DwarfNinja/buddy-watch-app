class Measure {
  int measureId;
  String userId;
  DateTime createdAt;
  double respiratoryRate;
  double temperature;
  double heartRate;
  double oxygenSaturation;

  Measure({
    required this.measureId,
    required this.userId,
    required this.createdAt,
    required this.respiratoryRate,
    required this.temperature,
    required this.heartRate,
    required this.oxygenSaturation,
  });

  factory Measure.fromJson(Map<String, dynamic> json) {
    return Measure(
      measureId: json['measure_id'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
      respiratoryRate: json['respiratory_rate'],
      temperature: json['temperature'].toDouble(),
      heartRate: json['heart_rate'],
      oxygenSaturation: json['oxygen_saturation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'measure_id': measureId,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
      'respiratory_rate': respiratoryRate,
      'temperature': temperature,
      'heart_rate': heartRate,
      'oxygen_saturation': oxygenSaturation,
    };
  }
}
