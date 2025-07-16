import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trotrolive_mobile_new/presentation/location/bloc/location_bloc.dart';
import 'package:trotrolive_mobile_new/presentation/trips/repository/data/trips_api_service.dart';
import 'package:trotrolive_mobile_new/presentation/trips/repository/model/trips_model.dart';
part 'trips_event.dart';
part 'trips_state.dart';

class TripsBloc extends Bloc<TripsEvent, TripsState> {
  final tripService = TripsRemoteApiService();
  final LocationBloc locationbloc;

  TripsBloc(this.locationbloc) : super(TripsInitial()) {
    on<FetchTripEvent>(fetchTrips);
  }

  Future<List<TripsModel>?> fetchTrips(
      FetchTripEvent event, Emitter<TripsState> emit) async {
    try {
      emit(TripsLoading());
      debugPrint("Trips Loading...");

      String? start = "Terminal Abeka lapaz";
      String? end = "Terminal Kasoa Station";

      String? startingPoint = start.trim().toLowerCase();
      //event.startingPoint!.trim().toLowerCase();
      String? destination = end.trim().toLowerCase();
      // event.destination!.trim().toLowerCase();

      final fetchTrips =
          await tripService.fetchTripsApi(startingPoint, destination);
      if (fetchTrips != null) {
        List<TripsModel>? viceVersaTrips = await tripService.fetchTripsApi(
          startingPoint,
          destination,
        );

        List<TripsModel> allTrips = fetchTrips;
        if (viceVersaTrips != null) {
          // allTrips.addAll(viceVersaTrips);
        }

        Set<TripsModel> uniqueTrips = {};

        for (var trip in allTrips) {
          if ((trip.startStation.name.trim().toLowerCase() == startingPoint &&
                  trip.destination.name.trim().toLowerCase() == destination) ||
              (trip.startStation.name.trim().toLowerCase() == destination &&
                  trip.destination.name.trim().toLowerCase() ==
                      startingPoint)) {
            uniqueTrips.add(trip);
          }
        }

        for (var trip in allTrips) {
          if (!((trip.startStation.name.trim().toLowerCase() == startingPoint &&
                      trip.destination.name.trim().toLowerCase() ==
                          destination) ||
                  (trip.startStation.name.trim().toLowerCase() == destination &&
                      trip.destination.name.trim().toLowerCase() ==
                          startingPoint)) &&
              (trip.startStation.name.trim().toLowerCase() == startingPoint ||
                  trip.destination.name.trim().toLowerCase() == destination ||
                  trip.startStation.name.trim().toLowerCase() == destination ||
                  trip.destination.name.trim().toLowerCase() ==
                      startingPoint)) {
            uniqueTrips.add(trip);
          }
        }
        debugPrint("Trips received: ${uniqueTrips.length}");

        debugPrint("Trips Fetched Successful => ${uniqueTrips.toList()}");
        emit(
          TripsFetchedState(
            message: "Trips Fetched Successfuly",
            trips: uniqueTrips.toList(),
          ),
        );
      } else {
        emit(TripsFailureState(error: 'An unexpected error occured'));
      }
    } catch (error) {
      emit(TripsFailureState(error: 'Error fetching trips: $error'));
      debugPrint('Error fetching trips: $error');
    }
    return null;
  }
}
