import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geodesy/geodesy.dart';
import 'package:location/location.dart';
import 'package:trotrolive_mobile_new/data/dio/dio_helper.dart';

import '../../../../utils/constants/api constants/api_constants.dart';
import '../model/stations_model.dart';

class StationsRemoteApiService {
  static Future<List<StationModel>?> fetchStationsApi(
      double userLatitude, double userLongitude) async {
    try {
      List<StationModel> sList = [];

      final response = await DioHelper.getAllData(
        url: stationsUrl,
        queryParameters: {},
      );

      if (response.statusCode == 200) {
        var jsonString = jsonDecode(response.data);
        var stationsList = jsonString['stations'];

        if (stationsList != null && stationsList is Iterable) {
          for (Map<String, dynamic> item in stationsList) {
            var station = StationModel.fromJson(item);

            if (isStationNearby(station, userLongitude, userLatitude)) {
              sList.add(station);
            }
          }
          return sList;
        } else {
          debugPrint('Invalid data format. Response body: $jsonString');

          return null;
        }
      } else {
        debugPrint("Error, HTTP Error: ${response.statusCode}");
        return null;
      }
    } on DioException {
      throw Error;
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

    // Convert distance from meters to kilometers
    double distanceInKm = (distanceNum as double) / 1000.0;
    // Set the distanceToUser property
    station.distanceToUser = distanceInKm;

    const double maxDistance = 200.0; //6 Maximum distance in kilometers

    print('Distance to ${station.name}: $distanceInKm km');

    return distanceInKm <= maxDistance;
  }
}
