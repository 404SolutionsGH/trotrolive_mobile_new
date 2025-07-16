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
  String name;
  dynamic stationAddress;
  List<double> coordinates;
  dynamic image;
  bool isBusStop;
  int city;
  DateTime createdAt;
  DateTime updatedAt;

  Ation({
    required this.name,
    required this.stationAddress,
    required this.coordinates,
    required this.image,
    required this.isBusStop,
    required this.city,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Ation.fromJson(Map<String, dynamic> json) => Ation(
        name: json["name"] ?? "",
        stationAddress: json["station_address"] ?? "",
        coordinates: json["coordinates"] != null
            ? List<double>.from(json["coordinates"].map((x) => x?.toDouble()))
            : [],
        image: json["image"],
        isBusStop: json["is_bus_stop"] ?? false,
        city: json["city"] ?? 0,
        createdAt:
            DateTime.tryParse(json["created_at"] ?? "") ?? DateTime.now(),
        updatedAt:
            DateTime.tryParse(json["updated_at"] ?? "") ?? DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "station_address": stationAddress,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
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
