class Measure {
  int id;
  String userId;
  DateTime createdAt;
  double respiratoryRate;
  double temperature;
  double heartRate;
  double oxygenSaturation;

  Measure({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.respiratoryRate,
    required this.temperature,
    required this.heartRate,
    required this.oxygenSaturation,
  });

  factory Measure.fromJson(Map<String, dynamic> json) {
    return Measure(
      id: json['id'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
      respiratoryRate: (json['respiratory_rate'] as int).toDouble(),
      temperature: (json['temperature'] as int).toDouble(),
      heartRate: (json['heart_rate'] as int).toDouble(),
      oxygenSaturation: (json['oxygen_saturation'] as int).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
      'respiratory_rate': respiratoryRate,
      'temperature': temperature,
      'heart_rate': heartRate,
      'oxygen_saturation': oxygenSaturation,
    };
  }
  @override
  String toString() {
    return '{id: $id, '
        'user_id: $userId, '
        'created_at: $createdAt, '
        'respiratory_rate: $respiratoryRate, t'
        'emperature: $temperature, '
        'heart_rate: $heartRate,'
        'oxygen_saturation: $oxygenSaturation}';
  }
}
