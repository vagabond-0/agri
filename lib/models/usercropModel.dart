class UserCrop {
  final String id;
  final String cropName;
  final int timeRequiredForHarvest; // Adjusted field name to camelCase
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
  final String timeWater; // Add this field as a String
  final int daysRemaining;
  UserCrop({
    required this.id,
    required this.cropName,
    required this.timeRequiredForHarvest,
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
    required this.timeWater, 
    required this.daysRemaining// Include timeWater in the constructor
  });

  factory UserCrop.fromJson(Map<String, dynamic> json) {
    return UserCrop(
      id: json['id'] as String,
      cropName: json['cropName'] as String,
      timeRequiredForHarvest: json['harvestTime'] as int, // Use harvestTime here
      weatherStart: (json['weatherStart'] as num).toDouble(),
      weatherEnd: (json['weatherEnd'] as num).toDouble(),
      humidityStart: (json['humidityStart'] as num).toDouble(),
      humidityEnd: (json['humidityEnd'] as num).toDouble(),
      suitableMonthStart: json['suitableMonthStart'] as String,
      suitableMonthEnd: json['suitableMonthEnd'] as String,
      marketPrice: json['marketPrice'] as int,
      soilType: json['soilType'] as String,
      soilPh: (json['soilPh'] as num).toDouble(),
      soilMoisture: (json['soilMoisture'] as num).toDouble(),
      timeWater: json['timeWater'] as String, // Deserialize timeWater
      daysRemaining:json['daysRemaining'] as int
    );
  }
}
