//Creating a class user to store the data;
class positionOffset {
  final double x_val_azoz;
  final double x_val_seyam;
  final double y_val_azoz;
  final double y_val_seyam;


  positionOffset({
    required this.x_val_azoz,
    required this.x_val_seyam,
    required this.y_val_azoz,
    required this.y_val_seyam,
  });

  factory positionOffset.fromJson(Map<String, dynamic> json) {
    return positionOffset(
      x_val_azoz: json['x_val_azoz'],
      x_val_seyam: json['x_val_seyam'],
      y_val_azoz: json['y_val_azoz'],
      y_val_seyam: json['y_val_seyam'],
    );
  }
}
