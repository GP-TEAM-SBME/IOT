//Creating a class user to store the data;
class sensorReading {
  final double temp_value;
  final double hum_value;
  final String InDtTm;

  sensorReading({
    required this.temp_value,
    required this.hum_value,
    required this.InDtTm,
  });

  factory sensorReading.fromJson(Map<String, dynamic> json) {
    return sensorReading(
      temp_value: json['temp_value'],
      hum_value: json['hum_value'],
      InDtTm: json['InDtTm'],
    );
  }
}


