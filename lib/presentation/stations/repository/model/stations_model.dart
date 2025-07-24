class StationModel {
  String id;
  String name;
  dynamic stationModelAddress;
  double latitude;
  double longitude;
  dynamic image;
  bool isBusStop;
  int city;
  DateTime createdAt;
  DateTime updatedAt;
  double distanceToUser;
  int clickCount;

  StationModel({
    required this.id,
    required this.name,
    required this.stationModelAddress,
    required this.latitude,
    required this.longitude,
    required this.image,
    required this.isBusStop,
    required this.city,
    required this.createdAt,
    required this.updatedAt,
    this.distanceToUser = 0.0,
    required this.clickCount,
  });

  /// From JSON (e.g., from API)
  factory StationModel.fromJson(Map<String, dynamic> json) {
    return StationModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      stationModelAddress: json['station_address'] ?? '',
      latitude: double.tryParse(json['station_latitude'] ?? '0') ?? 0.0,
      longitude: double.tryParse(json['station_longitude'] ?? '0') ?? 0.0,
      image: json['image_url'],
      isBusStop: json['is_bus_stop'] ?? false,
      city: 0, // Update if you receive city from API
      createdAt: DateTime.now(), // Replace if actual timestamps are provided
      updatedAt: DateTime.now(),
      clickCount: 0, // Replace if click count is returned from API
    );
  }

  /// Optional: From Firestore (if used)
  factory StationModel.fromFirestore(Map<String, dynamic> data) {
    return StationModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      stationModelAddress: data['stationModelAddress'] ?? '',
      latitude: data['latitude']?.toDouble() ?? 0.0,
      longitude: data['longitude']?.toDouble() ?? 0.0,
      image: data['image'],
      isBusStop: data['isBusStop'] ?? false,
      city: data['city'] ?? 0,
      createdAt: data['createdAt'] ?? DateTime.now(),
      updatedAt: data['updatedAt'] ?? DateTime.now(),
      clickCount: data['clickCount'] ?? 0,
    );
  }

  /// To JSON (for Firestore or local storage)
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "stationModelAddress": stationModelAddress,
        "latitude": latitude,
        "longitude": longitude,
        "image": image,
        "is_bus_stop": isBusStop,
        "city": city,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "clickCount": clickCount,
      };
}
