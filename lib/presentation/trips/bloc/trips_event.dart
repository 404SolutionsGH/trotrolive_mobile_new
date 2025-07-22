part of 'trips_bloc.dart';

sealed class TripsEvent {}

class FetchTripEvent extends TripsEvent {
  final String? startingPoint;
  final String? destination;
  FetchTripEvent({
    this.startingPoint,
    this.destination,
  });
}

class LoadMoreTripsEvent extends TripsEvent {
  final String? nextUrl;
  final List<TripsModel> currentTrips;

  LoadMoreTripsEvent({
    required this.nextUrl,
    required this.currentTrips,
  });
}
