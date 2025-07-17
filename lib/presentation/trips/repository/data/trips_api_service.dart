import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../data/dio/dio_helper.dart';
import '../../../../utils/constants/api constants/api_constants.dart';
import '../model/trips_model.dart';

class TripsRemoteApiService {
  /// Fetch all paginated trips from the API until no `next` is available
  ///

  Future<PaginatedTripsResponse?> fetchTripsApi(
    String? startingPoint,
    String? destination, {
    String? url,
  }) async {
    try {
      final requestUrl = url ??
          '$tripsUrl?startingPoint=$startingPoint&destination=$destination';

      final response = await DioHelper.getAllData(
        url: requestUrl,
        queryParameters: {},
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map<String, dynamic> && data.containsKey('results')) {
          final List<TripsModel> tripsList = [];

          for (var item in data['results']) {
            if (item is Map<String, dynamic>) {
              tripsList.add(TripsModel.fromJson(item));
            }
          }

          return PaginatedTripsResponse(
            trips: tripsList,
            nextUrl: data['next'],
          );
        } else {
          debugPrint('Unexpected data structure: $data');
        }
      } else {
        debugPrint("Server error: ${response.statusCode}");
      }
    } on DioException catch (e) {
      debugPrint("Dio error: $e");
    } catch (e) {
      debugPrint("Unexpected error: $e");
    }

    return null;
  }
}

class PaginatedTripsResponse {
  final List<TripsModel> trips;
  final String? nextUrl;

  PaginatedTripsResponse({required this.trips, this.nextUrl});
}
