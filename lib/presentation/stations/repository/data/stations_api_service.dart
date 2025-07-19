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

      final response = await DioHelper.getAllData(
        url: stationsUrl,
        //?station_latitude=5.5768461&station_longitude=-0.3266422',
        queryParameters: {},
      );

      if (response.statusCode == 200) {
        final jsonData = response.data;

        final stationsList = jsonData['results'] ?? jsonData['stations'];

        if (stationsList != null && stationsList is Iterable) {
          for (Map<String, dynamic> item in stationsList) {
            var station = StationModel.fromJson(item);

            if (isStationNearby(station, userLongitude!, userLatitude!)) {
              sList.add(station);
            }
          }

          if (sList.isEmpty) {
            for (Map<String, dynamic> item in stationsList) {
              var station = StationModel.fromJson(item);
              sList.add(station);
            }
          }

          return sList;
        } else {
          debugPrint('Invalid data format. Response body: $jsonData');
          return null;
        }
      } else {
        debugPrint("Error, HTTP Error: ${response.statusCode}");
        return null;
      }
    } on DioException catch (e) {
      debugPrint("DioException occurred: $e");
      return null;
    } catch (e) {
      debugPrint("General error: $e");
      return null;
    }
  }

  static bool isStationNearby(
      StationModel station, double userLatitude, double userLongitude) {
    final Geodesy geodesy = Geodesy();

    LatLng userLatLng = LatLng(userLatitude, userLongitude);
    LatLng stationLatLng = LatLng(
        station.coordinates[0] as double, station.coordinates[1] as double);

    num distanceNum =
        geodesy.distanceBetweenTwoGeoPoints(userLatLng, stationLatLng);

    double distanceInKm = (distanceNum as double) / 1000.0;
    station.distanceToUser = distanceInKm;

    const double maxDistance = 10.0;

    debugPrint('Distance to ${station.name}: $distanceInKm km');

    return distanceInKm <= maxDistance;
  }
}
