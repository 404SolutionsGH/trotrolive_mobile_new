class TripsModel {
  Ation startStation;
  Ation destination;
  String fare;
  RouteModel route;
  int withinCity;
  DateTime createdAt;
  DateTime updatedAt;

  TripsModel({
    required this.startStation,
    required this.destination,
    required this.fare,
    required this.route,
    required this.withinCity,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  String toString() {
    return 'Trip from ${startStation.name} to ${destination.name}';
  }

  factory TripsModel.fromJson(Map<String, dynamic> json) {
    try {
      return TripsModel(
        startStation: Ation.fromJson(json["start_station"] ?? {}),
        destination: Ation.fromJson(json["destination"] ?? {}),
        fare: json["fare"] ?? "",
        route: RouteModel.fromJson(json["route"] ?? {}),
        withinCity: json["within_city"] ?? 0,
        createdAt:
            DateTime.tryParse(json["created_at"] ?? "") ?? DateTime.now(),
        updatedAt:
            DateTime.tryParse(json["updated_at"] ?? "") ?? DateTime.now(),
      );
    } catch (e) {
      print(" Error parsing TripsModel: $e");
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
        "start_station": startStation.toJson(),
        "destination": destination.toJson(),
        "fare": fare,
        "route": route,
        "within_city": withinCity,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Ation {
  final String name;
  final String stationAddress;
  final double stationLatitude;
  final double stationLongitude;
  final String? image;
  final bool isBusStop;
  final int city;
  final DateTime createdAt;
  final DateTime updatedAt;

  Ation({
    required this.name,
    required this.stationAddress,
    required this.stationLatitude,
    required this.stationLongitude,
    this.image,
    required this.isBusStop,
    required this.city,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Ation.fromJson(Map<String, dynamic> json) {
    return Ation(
      name: json["name"]?.toString() ?? '',
      stationAddress: json["station_address"]?.toString() ?? '',
      stationLatitude: _parseDouble(json["station_latitude"]) ?? 0.0,
      stationLongitude: _parseDouble(json["station_longitude"]) ?? 0.0,
      image: json["image"]?.toString(),
      isBusStop: json["is_bus_stop"] == true || json["is_bus_stop"] == 'true',
      city: _parseInt(json["city"]) ?? 0,
      createdAt: _parseDateTime(json["created_at"]) ?? DateTime.now(),
      updatedAt: _parseDateTime(json["updated_at"]) ?? DateTime.now(),
    );
  }

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  static DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "station_address": stationAddress,
        "station_latitude": stationLatitude,
        "station_longitude": stationLongitude,
        "image": image,
        "is_bus_stop": isBusStop,
        "city": city,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class RouteModel {
  final String id;
  final String shortName;
  final String longName;
  final String description;
  final String routeType;
  final String color;
  final String source;

  RouteModel({
    required this.id,
    required this.shortName,
    required this.longName,
    required this.description,
    required this.routeType,
    required this.color,
    required this.source,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) => RouteModel(
        id: json['gtfs_route_id'] ?? '',
        shortName: json['short_name'] ?? '',
        longName: json['long_name'] ?? '',
        description: json['description'] ?? '',
        routeType: json['route_type'] ?? '',
        color: json['color'] ?? '',
        source: json['source'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'gtfs_route_id': id,
        'short_name': shortName,
        'long_name': longName,
        'description': description,
        'route_type': routeType,
        'color': color,
        'source': source,
      };
}
