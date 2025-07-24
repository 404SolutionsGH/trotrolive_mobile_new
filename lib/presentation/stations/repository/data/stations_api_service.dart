import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geodesy/geodesy.dart';
import 'package:trotrolive_mobile_new/data/dio/dio_helper.dart';
import 'package:trotrolive_mobile_new/utils/constants/api%20constants/api_constants.dart';
import '../model/stations_model.dart';

class StationsRemoteApiService {
  Future<List<StationModel>?> fetchStationsApi(
      double? userLatitude, double? userLongitude) async {
    try {
      List<StationModel> sList = [];
      String? nextUrl = stationsUrl;
      int pageCount = 0;
      const maxPages = 5;

      while (nextUrl != null && pageCount < maxPages) {
        pageCount++;
        debugPrint("🔄 Fetching page $pageCount: $nextUrl");

        final response = await DioHelper.getAllData(
          url: nextUrl,
          queryParameters: {},
        );

        if (response.statusCode == 200) {
          final jsonData = response.data;
          final stationsList = jsonData['results'] ?? jsonData['stations'];
          debugPrint(
              '📦 Page $pageCount - Stations: ${stationsList?.length ?? 0}');

          if (stationsList != null && stationsList is Iterable) {
            for (Map<String, dynamic> item in stationsList) {
              var station = StationModel.fromJson(item);

              if (userLatitude != null &&
                  userLongitude != null &&
                  isStationNearby(station, userLatitude, userLongitude)) {
                sList.add(station);
              }
            }

            // Prepare for next page
            nextUrl = jsonData['next'];
          } else {
            debugPrint('⚠️ Invalid stations list format');
            break;
          }
        } else {
          debugPrint("❌ HTTP error: ${response.statusCode}");
          break;
        }
      }

      // If no nearby stations found, fallback to first page
      if (sList.isEmpty && pageCount > 0) {
        debugPrint(
            "⚠️ No nearby stations found. Using fallback from first page...");

        final firstPageResponse = await DioHelper.getAllData(
          url: stationsUrl,
          queryParameters: {},
        );

        final firstPageData = firstPageResponse.data;
        final fallbackList =
            firstPageData['results'] ?? firstPageData['stations'];

        if (fallbackList != null && fallbackList is Iterable) {
          for (Map<String, dynamic> item in fallbackList) {
            var station = StationModel.fromJson(item);
            sList.add(station);
          }
        }
      }

      debugPrint("✅ Final station count: ${sList.length}");
      return sList;
    } on DioException catch (e) {
      debugPrint("❌ DioException: $e");
      return null;
    } catch (e) {
      debugPrint("❌ General error: $e");
      return null;
    }
  }

  static bool isStationNearby(
      StationModel station, double userLatitude, double userLongitude) {
    final Geodesy geodesy = Geodesy();

    LatLng userLatLng = LatLng(userLatitude, userLongitude);
    LatLng stationLatLng = LatLng(station.latitude, station.longitude);

    num distanceInMeters =
        geodesy.distanceBetweenTwoGeoPoints(userLatLng, stationLatLng);
    double distanceInKm = distanceInMeters / 1000.0;

    station.distanceToUser = distanceInKm;

    debugPrint(
        '📍 ${station.name} → ${distanceInKm.toStringAsFixed(2)} km away');

    return distanceInKm <= 20.0;
  }
}
