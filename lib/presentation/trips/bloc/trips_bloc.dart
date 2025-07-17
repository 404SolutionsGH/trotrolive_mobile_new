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
  bool isLoadingMore = false;

  TripsBloc(this.locationbloc) : super(TripsInitial()) {
    on<FetchTripEvent>(fetchTrips);
    on<LoadMoreTripsEvent>((event, emit) async {
      if (isLoadingMore) return;
      isLoadingMore = true;
      emit(TripsLoadingMore());

      try {
        final response = await tripService.fetchTripsApi(
          null,
          null,
          url: event.nextUrl,
        );

        if (response != null) {
          final allTrips = [...event.currentTrips, ...response.trips];
          emit(TripsFetchedState(
            message: "Trips Loaded",
            trips: allTrips,
            nextUrl: response.nextUrl,
          ));
        }
      } catch (e) {
        emit(TripsFailureState(error: 'Error loading more trips: $e'));
      } finally {
        isLoadingMore = false;
      }
    });
  }

  Future<void> fetchTrips(
      FetchTripEvent event, Emitter<TripsState> emit) async {
    try {
      emit(TripsLoading());
      debugPrint("Trips Loading...");

      final String? startingPoint = "Terminal Abeka lapaz".trim().toLowerCase();
      final String? destination = "Terminal Kasoa Station".trim().toLowerCase();

      List<TripsModel> allTrips = [];
      String? nextUrl;
      int pageCount = 0;
      const int maxPages = 5;

      do {
        final response = await tripService.fetchTripsApi(
          startingPoint,
          destination,
          url: nextUrl,
        );

        if (response != null) {
          allTrips.addAll(response.trips);
          nextUrl = response.nextUrl;
          pageCount++;
        } else {
          break;
        }
      } while (nextUrl != null && pageCount < maxPages);

      final Set<TripsModel> uniqueTrips = {};

      for (var trip in allTrips) {
        if ((trip.startStation.name.trim().toLowerCase() == startingPoint &&
                trip.destination.name.trim().toLowerCase() == destination) ||
            (trip.startStation.name.trim().toLowerCase() == destination &&
                trip.destination.name.trim().toLowerCase() == startingPoint)) {
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
                trip.destination.name.trim().toLowerCase() == startingPoint)) {
          uniqueTrips.add(trip);
        }
      }

      debugPrint("Trips Fetched: ${uniqueTrips.length}");
      emit(TripsFetchedState(
        message: "Trips Fetched Successfully",
        trips: uniqueTrips.toList(),
        nextUrl: nextUrl,
      ));
    } catch (e) {
      emit(TripsFailureState(error: 'Error fetching trips: $e'));
    }
  }

  Future<void> loadMoreTrips(
    LoadMoreTripsEvent event,
    Emitter<TripsState> emit,
  ) async {
    if (event.nextUrl == null) return;

    try {
      emit(TripsLoadingMore()); // optional loading state while appending

      final response = await tripService.fetchTripsApi(
        null,
        null,
        url: event.nextUrl,
      );

      if (response != null) {
        final allTrips = [...event.currentTrips, ...response.trips];

        emit(TripsFetchedState(
          message: "More Trips Loaded",
          trips: allTrips,
          nextUrl: response.nextUrl,
        ));
      } else {
        emit(TripsFailureState(error: 'Failed to load more trips'));
      }
    } catch (e) {
      emit(TripsFailureState(error: 'Error loading more trips: $e'));
    }
  }
}
