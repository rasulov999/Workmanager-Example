class DataFields {
  static String id = "id";
  static String lat = "lat";
  static String lon = "lon";
  static String dateTime = "dateTime";
}

class DataModel {
  DataModel({
    this.id,
    required this.lat,
    required this.lon,
    required this.dateTime,
  });
  int? id;
  final dynamic lat;
  final dynamic lon;
  final String dateTime;

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'] as int? ?? 0,
      lat: json['lat'] as String? ?? "",
      lon: json['lon'] as String? ?? "",
      dateTime: json['dateTime'] as String? ?? "",
    );
  }
  Map<String, dynamic> toJson() => {
        DataFields.id: id,
        DataFields.lat: lat,
        DataFields.lon: lon,
        DataFields.dateTime: dateTime
      };

  DataModel copyWith({
    int? id,
    String? lat,
    String? lon,
    String? dateTime,
  }) {
    return DataModel(
      id: id ?? this.id,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}
