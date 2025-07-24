import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trotrolive_mobile_new/presentation/trips/repository/data/trips_api_service.dart';
import 'package:trotrolive_mobile_new/presentation/trips/repository/model/trips_model.dart';
part 'trips_event.dart';
part 'trips_state.dart';

class TripsBloc extends Bloc<TripsEvent, TripsState> {
  final tripService = TripsRemoteApiService();
  bool isLoadingMore = false;

  TripsBloc() : super(TripsInitial()) {
    on<FetchTripEvent>(fetchTrips);
    on<LoadMoreTripsEvent>(loadMoreTrips);
  }
/*
  Future<void> fetchTrips(
      FetchTripEvent event, Emitter<TripsState> emit) async {
    try {
      emit(TripsLoading());
      debugPrint("Trips Loading...");

      final String? startingPoint = event.startingPoint;
      final String? destination = event.destination;

      if (startingPoint == null || destination == null) {
        emit(TripsFailureState(
            error: 'Starting point or destination is missing.'));
        return;
      }

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
      debugPrint(e.toString());
      emit(TripsFailureState(error: 'Error fetching trips: $e'));
    }
  }
*/
// ✅ Normalize station names for reliable comparison
  String normalize(String name) {
    return name
        .replaceAll(RegExp(r'terminal', caseSensitive: false), '')
        .trim()
        .toLowerCase();
  }

  Future<void> fetchTrips(
      FetchTripEvent event, Emitter<TripsState> emit) async {
    try {
      emit(TripsLoading());
      debugPrint("🚦 Trips Loading...");

      final String? startingPoint = event.startingPoint;
      final String? destination = event.destination;

      if (startingPoint == null || destination == null) {
        return debugPrint('Starting point or destination is missing');
      }

      debugPrint("🧭 Params: start=$startingPoint, dest=$destination");

      final inputStart = normalize(startingPoint);
      final inputDest = normalize(destination);

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
        final tripStart = normalize(trip.startStation.name);
        final tripDest = normalize(trip.destination.name);

        // Match both directions
        if ((tripStart == inputStart && tripDest == inputDest) ||
            (tripStart == inputDest && tripDest == inputStart)) {
          uniqueTrips.add(trip);
        }
      }

      // Optional fallback: broader matching
      if (uniqueTrips.isEmpty) {
        for (var trip in allTrips) {
          final tripStart = normalize(trip.startStation.name);
          final tripDest = normalize(trip.destination.name);

          if (tripStart.contains(inputStart) ||
              tripDest.contains(inputDest) ||
              tripStart.contains(inputDest) ||
              tripDest.contains(inputStart)) {
            uniqueTrips.add(trip);
          }
        }
      }

      debugPrint("🎯 Trips Fetched: ${uniqueTrips.length}");
      for (var trip in uniqueTrips) {
        debugPrint("📍 ${trip.startStation.name} → ${trip.destination.name}");
      }

      emit(TripsFetchedState(
        message: "Trips Fetched Successfully",
        trips: uniqueTrips.toList(),
        nextUrl: nextUrl,
      ));
    } catch (e) {
      debugPrint("❌ Exception: $e");
      emit(TripsFailureState(error: 'Error fetching trips: $e'));
    }
  }

  Future<void> loadMoreTrips(
      LoadMoreTripsEvent event, Emitter<TripsState> emit) async {
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
  }
}
