//Creating a class user to store the data;
class segmentReading {
  final String segment;
  final double xVal;
  final double yVal;

  segmentReading({
    required this.segment,
    required this.xVal,
    required this.yVal,
  });

  factory segmentReading.fromJson(Map<String, dynamic> json) {
    return segmentReading(
      segment: json['segment'],
      xVal: json['xVal'],
      yVal: json['yVal'],
    );
  }
}
