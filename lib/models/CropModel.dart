class Crop {
  final String id;
  final String cropName;
  final int TimeRequiredForHarvest;
  final double weatherStart;
  final double weatherEnd;
  final double humidityStart;
  final double humidityEnd;
  final String suitableMonthStart;
  final String suitableMonthEnd;
  final int marketPrice;
  final String soilType;
  final double soilPh;
  final double soilMoisture;

  Crop({
    required this.id,
    required this.cropName,
    required this.TimeRequiredForHarvest,
    required this.weatherStart,
    required this.weatherEnd,
    required this.humidityStart,
    required this.humidityEnd,
    required this.suitableMonthStart,
    required this.suitableMonthEnd,
    required this.marketPrice,
    required this.soilType,
    required this.soilPh,
    required this.soilMoisture,
  });

  factory Crop.fromJson(Map<String, dynamic> json) {
    return Crop(
      id: json['id'],
      cropName: json['cropName'],
      TimeRequiredForHarvest: json['TimeRequiredForHarvest'],
      weatherStart: json['weatherStart'],
      weatherEnd: json['weatherEnd'],
      humidityStart: json['humidityStart'],
      humidityEnd: json['humidityEnd'],
      suitableMonthStart: json['suitableMonthStart'],
      suitableMonthEnd: json['suitableMonthEnd'],
      marketPrice: json['marketPrice'],
      soilType: json['soilType'],
      soilPh: json['soilPh'],
      soilMoisture: json['soilMoisture'],
    );
  }
}
