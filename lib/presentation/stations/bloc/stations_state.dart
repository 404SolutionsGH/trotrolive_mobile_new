// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'stations_bloc.dart';

sealed class StationState {}

class StationInitial extends StationState {}

class StationLoading extends StationState {}

class StationFetchedState extends StationState {
  final String message;
  final List<StationModel>? stations;
  bool isLoaded;

  StationFetchedState({
    required this.message,
    required this.stations,
    this.isLoaded = false,
  });
}

class StationLoadingMore extends StationState {}

class StationFailureState extends StationState {
  String error;
  StationFailureState({
    required this.error,
  });
}
