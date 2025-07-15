// To parse this JSON data, do
//
//     final  = FromJson(jsonString);

class TripsModel {
  Ation startStation;
  Ation destination;
  String fare;
  String route;
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

  factory TripsModel.fromJson(Map<String, dynamic> json) {
    try {
      return TripsModel(
        startStation: Ation.fromJson(json["start_station"]),
        destination: Ation.fromJson(json["destination"]),
        fare: json["fare"],
        route: json["route"],
        withinCity: json["within_city"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
    } catch (e) {
      print("Error parsing TripsModel: $e");
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
        name: json["name"],
        stationAddress: json["station_address"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
        image: json["image"],
        isBusStop: json["is_bus_stop"],
        city: json["city"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
