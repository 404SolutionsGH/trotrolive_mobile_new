// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'trips_bloc.dart';

class TripsState {}

class TripsInitial extends TripsState {}

class TripsLoading extends TripsState {}

class TripsFetchedState extends TripsState {
  String message;
  TripsFetchedState({
    required this.message,
  });
}

class TripsFailureState extends TripsState {
  String error;
  TripsFailureState({
    required this.error,
  });
}
