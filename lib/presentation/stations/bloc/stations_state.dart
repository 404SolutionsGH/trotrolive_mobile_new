part of 'stations_bloc.dart';

sealed class StationState {}

class StationInitial extends StationState {}

class StationLoading extends StationState {}

class StationFetchedState extends StationState {
  final String message;
  final List<StationModel>? stations;
  bool isLoaded;
  final bool fromCache;

  StationFetchedState({
    required this.message,
    required this.stations,
    this.isLoaded = false,
    this.fromCache = false,
  });
}

class StationLoadingMore extends StationState {}

class StationFailureState extends StationState {
  String error;
  StationFailureState({
    required this.error,
  });
}
