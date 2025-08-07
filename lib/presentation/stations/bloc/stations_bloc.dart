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
    try {
      final locationState = locationbloc.state;
      debugPrint("📍 LocationBloc State: $locationState");

      if (locationState is LocationFetchedState) {
        double? userLatitude = locationState.latitude;
        double? userLongitude = locationState.longitude;
        debugPrint("📍 User Lat: $userLatitude, Lng: $userLongitude");

        // STEP 1: Try loading from cache first
        final cached = await StationCacheHelper.getCachedStations();

        if (cached.isNotEmpty) {
          debugPrint('🗂️ Loaded ${cached.length} stations from cache');
          emit(StationFetchedState(
            message: 'Loaded from cache',
            stations: cached,
            isLoaded: true,
            fromCache: true,
          ));
        } else {
          debugPrint('📂 No cached data found. Showing shimmer...');
          emit(StationLoading());
        }

        // STEP 2: Fetch from API in background
        final freshStations =
            await stationService.fetchStationsApi(userLatitude, userLongitude);

        if (freshStations != null && freshStations.isNotEmpty) {
          debugPrint('🌐 Fetched ${freshStations.length} stations from API');

          // Optional: Check if fresh is different from cached
          final isDifferent = freshStations.length != cached.length;

          if (isDifferent) {
            await StationCacheHelper.cacheStations(freshStations);
            emit(StationFetchedState(
              message: 'Stations Fetched Successfully',
              stations: freshStations,
              isLoaded: true,
              fromCache: false,
            ));
          } else {
            debugPrint('📦 Fetched data is same as cache, skipping re-emit');
          }
        } else {
          debugPrint('⚠️ No nearby stations found from API.');
          if (cached.isEmpty) {
            emit(StationFailureState(
                error: 'No nearby stations at your location.'));
          }
        }
      } else if (locationState is LocationFailure) {
        emit(StationFailureState(error: 'Location failed to load'));
      }
    } catch (error) {
      debugPrint('❌ Error fetching stations: $error');
      emit(StationFailureState(error: 'Error fetching stations: $error'));
    }
  }
}
