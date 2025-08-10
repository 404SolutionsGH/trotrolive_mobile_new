part of 'trips_bloc.dart';

sealed class TripsState {}

class TripsInitial extends TripsState {}

class TripsLoading extends TripsState {}

class TripsFetchedState extends TripsState {
  final String message;
  final List<TripsModel>? trips;
  final String? nextUrl;

  bool get hasMore => nextUrl != null;

  TripsFetchedState({
    required this.message,
    required this.trips,
    this.nextUrl,
  });
}

class TripsLoadingMore extends TripsState {
  final List<TripsModel>? previousTrips;

  TripsLoadingMore({this.previousTrips});
}

class TripsFailureState extends TripsState {
  String error;
  TripsFailureState({
    required this.error,
  });
}

class TripsEmptyState extends TripsState {
  String message;
  TripsEmptyState({
    required this.message,
  });
}
