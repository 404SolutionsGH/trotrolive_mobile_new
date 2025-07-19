part of 'stations_bloc.dart';

sealed class StationEvent {}

class FetchStationEvent extends StationEvent {
  final String? startingPoint;
  final String? destination;
  FetchStationEvent({
    this.startingPoint,
    this.destination,
  });
}

class LoadMoreStationEvent extends StationEvent {
  final String? nextUrl;
  final List<StationModel>? currentTrips;

  LoadMoreStationEvent({
    required this.nextUrl,
    required this.currentTrips,
  });
}
