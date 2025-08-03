import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../../../data/dio/dio_helper.dart';

class PolylineRemoteApiService {
  Future<List<LatLng>?> fetchRouteCoordinates(
    LatLng start,
    LatLng end,
  ) async {
    try {
      String? url;
      final requestUrl = url ??
          'https://router.project-osrm.org/route/v1/driving/'
              '${start.longitude},${start.latitude};'
              '${end.longitude},${end.latitude}?overview=full&geometries=geojson';

      debugPrint("Requesting: $requestUrl");

      final response = await DioHelper.getAllData(
        url: requestUrl,
        queryParameters: {},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final coordinates =
            data['routes'][0]['geometry']['coordinates'] as List;
        return coordinates
            .map((coord) => LatLng(coord[1].toDouble(), coord[0].toDouble()))
            .toList();
      } else {
        throw Exception('Failed to fetch polyline');
      }
    } on DioException catch (e) {
      debugPrint("Dio error: $e");
    } catch (e) {
      debugPrint("Unexpected error: $e");
    }
    return null;
  }
}
