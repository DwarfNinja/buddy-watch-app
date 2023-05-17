enum MeasurementType {
  heartRate,
  oxygenSaturation,
  respiratoryRate,
  temperature,
}

extension MeasurementTypeHelper on MeasurementType {

  static const names = {
    MeasurementType.heartRate: 'heart_rate',
    MeasurementType.oxygenSaturation: 'oxygen_saturation',
    MeasurementType.respiratoryRate: 'respiratory_rate',
    MeasurementType.temperature: 'temperature',
  };

  String? get value => names[this];
}