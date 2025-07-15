// ignore_for_file: public_member_api_docs, sort_constructors_first
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
