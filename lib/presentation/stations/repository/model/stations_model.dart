class StationModel {
  String name;
  dynamic stationModelAddress;
  List<double?> coordinates;
  dynamic image;
  bool isBusStop;
  int city;
  DateTime createdAt;
  DateTime updatedAt;
  double distanceToUser;
  int clickCount;
  String id;

  StationModel({
    required this.name,
    required this.stationModelAddress,
    required this.coordinates,
    required this.image,
    required this.isBusStop,
    required this.city,
    required this.createdAt,
    required this.updatedAt,
    this.distanceToUser = 0.0,
    required this.clickCount,
    required this.id,
  });

  factory StationModel.fromJson(Map<String, dynamic> json) => StationModel(
        id: json['id'].toString(),
        name: json['name'] ?? '',
        stationModelAddress: json['station_address'] ?? '',
        coordinates: [
          double.tryParse(json['station_latitude'] ?? '0') ?? 0.0,
          double.tryParse(json['station_longitude'] ?? '0') ?? 0.0,
        ],
        image: json['image_url'],
        isBusStop: json['is_bus_stop'] ?? false,
        city: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        clickCount: 0,
      );

  factory StationModel.fromFirestore(Map<String, dynamic> data) {
    return StationModel(
      clickCount: data['clickCount'] ?? 0,
      coordinates: data['coordinates'],
      name: data['name'],
      city: data['city'],
      createdAt: data['createdAt'],
      image: null,
      isBusStop: data['isBuStop'],
      stationModelAddress: null,
      updatedAt: data['updatedAt'],
      id: data['id'],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "stationModel_address": stationModelAddress,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "image": image,
        "is_bus_stop": isBusStop,
        "city": city,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
