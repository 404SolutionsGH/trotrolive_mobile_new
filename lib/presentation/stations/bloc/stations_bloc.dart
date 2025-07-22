import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trotrolive_mobile_new/presentation/location/bloc/location_bloc.dart';
import '../../../repository/cache/station_cache_helper.dart';
import '../repository/data/stations_api_service.dart';
import '../repository/model/stations_model.dart';

part 'stations_events.dart';
part 'stations_state.dart';

class StationBloc extends Bloc<StationEvent, StationState> {
  final LocationBloc locationbloc;
  final stationService = StationsRemoteApiService();
  List<StationModel>? nearbyStations;
  bool isLoaded = false;
  bool isStationPresent = false;

  StationBloc(this.locationbloc) : super(StationInitial()) {
    on<FetchStationEvent>(fetchStations);
  }

  Future<void> fetchStations(
      FetchStationEvent event, Emitter<StationState> emit) async {
    emit(StationLoading());
    debugPrint("Stations Loading...");

    try {
      final locationState = locationbloc.state;
      debugPrint("LocationBloc State: $locationState");

      if (locationState is LocationFetchedState) {
        double? userLatitude = locationState.latitude;
        double? userLongitude = locationState.longitude;
        debugPrint("Location Fetched: $userLatitude, $userLongitude");

        // Load from cache first
        final cached = await StationCacheHelper.getCachedStations();
        if (cached.isNotEmpty) {
          emit(StationFetchedState(
            message: 'Loaded from cache',
            stations: cached,
            isLoaded: true,
            fromCache: true,
          ));
        }

        // Then fetch from API
        nearbyStations =
            await stationService.fetchStationsApi(userLatitude, userLongitude);

        if (nearbyStations != null && nearbyStations!.isNotEmpty) {
          debugPrint('Stations Fetched');

          // Cache fetched stations
          await StationCacheHelper.cacheStations(nearbyStations!);

          return emit(StationFetchedState(
            message: 'Stations Fetched Successfully',
            stations: nearbyStations,
            isLoaded: true,
            fromCache: false,
          ));
        } else if (nearbyStations == null || nearbyStations!.isEmpty) {
          debugPrint('No nearby stations at your location.');
          emit(StationFailureState(
              error: 'No nearby stations at your location.'));
        }
      } else if (locationState is LocationFailure) {
        emit(StationFailureState(error: 'Your location couldn\'t load'));
      }
    } catch (error) {
      debugPrint(error.toString());
      emit(StationFailureState(error: 'Error fetching stations: $error'));
    }
  }

  // Future<void> fetchStations(
  //     FetchStationEvent event, Emitter<StationState> emit) async {
  //   emit(StationLoading());
  //   debugPrint("Stations Loading...");

  //   try {
  //     final locationState = locationbloc.state;
  //     debugPrint("LocationBloc State: $locationState");

  //     if (locationState is LocationFetchedState) {
  //       double? userLatitude = locationState.latitude;
  //       double? userLongitude = locationState.longitude;
  //       debugPrint("Location Fetched: $userLatitude, $userLongitude");

  //       if (userLatitude == null || userLongitude == null) {
  //         debugPrint("Error: Latitude or Longitude is null!");
  //         emit(StationFailureState(error: "User location not available."));
  //       }

  //       nearbyStations =
  //           await stationService.fetchStationsApi(userLatitude, userLongitude);
  //       if (nearbyStations != null) {
  //         debugPrint('Stations Fetched');
  //         return emit(
  //           StationFetchedState(
  //             message: 'Stations Fetched Successfuly',
  //             stations: nearbyStations,
  //             isLoaded: true,
  //           ),
  //         );
  //       } else if (nearbyStations == null) {
  //         debugPrint('No nearby stations at your location.');
  //         emit(StationFailureState(
  //             error: 'No nearby stations at your location.'));
  //       } else {
  //         debugPrint('User location is not available.');
  //       }
  //     } else if (locationState is LocationFailure) {
  //       emit(StationFailureState(error: 'Your location couldnt load'));
  //     }
  //   } catch (error) {
  //     debugPrint(error.toString());
  //     emit(StationFailureState(error: 'Error fetching stations: $error'));
  //   }
  // }
}
