import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
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
  String normalize(String name) {
    return name
        .replaceAll(RegExp(r'terminal', caseSensitive: false), '')
        .trim()
        .toLowerCase();
  }

  Future<void> fetchTrips(
    FetchTripEvent event,
    Emitter<TripsState> emit,
  ) async {
    try {
      emit(TripsLoading());
      debugPrint(
          "Loading trips from ${event.startingPoint} to ${event.destination}");

      // Validate inputs
      final startingPoint = event.startingPoint?.trim();
      final destination = event.destination?.trim();

      if (startingPoint == null ||
          destination == null ||
          startingPoint.isEmpty ||
          destination.isEmpty) {
        debugPrint('Please provide valid locations');
        // emit(TripsFailureState(error: 'Please provide valid locations'));
        return;
      }

      // Normalize inputs once
      final normalizedStart = normalize(startingPoint);
      final normalizedDest = normalize(destination);
      debugPrint(
          "Normalized params: start=$normalizedStart, dest=$normalizedDest");

      // Fetch trips with pagination
      final (trips, nextUrl) = await _fetchPaginatedTrips(
        startingPoint,
        destination,
        maxPages: 10,
      );

      // Filter relevant trips
      final filteredTrips = _filterRelevantTrips(
        trips,
        normalizedStart,
        normalizedDest,
      );

      if (filteredTrips.isEmpty) {
        emit(TripsEmptyState(message: 'No matching trips found'));
        return;
      }

      debugPrint("Fetched ${filteredTrips.length} trips");
      emit(TripsFetchedState(
        trips: filteredTrips,
        nextUrl: nextUrl,
        message: "Fetched ${filteredTrips.length} trips",
      ));
    } on DioException catch (e) {
      emit(TripsFailureState(error: "Dio error: $e"));
      debugPrint("Dio error: $e");
    } on SocketException {
      emit(TripsFailureState(error: 'No internet connection'));
    } on TimeoutException {
      emit(TripsFailureState(error: 'Request timed out'));
    } on FormatException {
      emit(TripsFailureState(error: 'Invalid data format'));
    } catch (e, stackTrace) {
      debugPrint("Error fetching trips: $e\n$stackTrace");
      emit(TripsFailureState(error: 'Failed to load trips'));
    }
  }

  Future<(List<TripsModel>, String?)> _fetchPaginatedTrips(
    String start,
    String dest, {
    int maxPages = 5,
  }) async {
    List<TripsModel> allTrips = [];
    String? nextUrl;
    int pageCount = 0;

    do {
      final response = await tripService.fetchTripsApi(
        start,
        dest,
        url: nextUrl,
      );

      if (response == null || response.trips.isEmpty) break;

      allTrips.addAll(response.trips);
      nextUrl = response.nextUrl;
      pageCount++;
    } while (pageCount < maxPages && nextUrl != null);

    return (allTrips, nextUrl);
  }

  List<TripsModel> _filterRelevantTrips(
    List<TripsModel> trips,
    String normalizedStart,
    String normalizedDest,
  ) {
    final exactMatches = <TripsModel>{};
    final partialMatches = <TripsModel>{};

    for (final trip in trips) {
      final tripStart = normalize(trip.startStation.name);
      final tripDest = normalize(trip.destination.name);

      // Exact matches (either direction)
      if ((tripStart == normalizedStart && tripDest == normalizedDest) ||
          (tripStart == normalizedDest && tripDest == normalizedStart)) {
        exactMatches.add(trip);
        continue;
      }

      // Partial matches
      if (tripStart.contains(normalizedStart) ||
          tripDest.contains(normalizedDest) ||
          tripStart.contains(normalizedDest) ||
          tripDest.contains(normalizedStart)) {
        partialMatches.add(trip);
      }
    }

    // Return exact matches if found, otherwise partial matches
    return exactMatches.isNotEmpty
        ? exactMatches.toList()
        : partialMatches.toList();
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
        return debugPrint('Starting point or destination is missing');
      }

      debugPrint("Params: start=$startingPoint, dest=$destination");

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
      } while (pageCount < maxPages);

      final Set<TripsModel> uniqueTrips = {};

      for (var trip in allTrips) {
        final tripStart = normalize(trip.startStation.name);
        final tripDest = normalize(trip.destination.name);

        if ((tripStart == inputStart && tripDest == inputDest) ||
            (tripStart == inputDest && tripDest == inputStart)) {
          uniqueTrips.add(trip);
        }
      }

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

      debugPrint("Trips Fetched: ${uniqueTrips.length}");
      for (var trip in uniqueTrips) {
        debugPrint("${trip.startStation.name} → ${trip.destination.name}");
      }

      emit(TripsFetchedState(
        message: "Trips Fetched Successfully",
        trips: uniqueTrips.toList(),
        nextUrl: nextUrl,
      ));
    } catch (e) {
      debugPrint("Exception: $e");
      emit(TripsFailureState(error: 'Error fetching trips: $e'));
    }
  }
*/
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
