import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../data/dio/dio_helper.dart';
import '../../../../utils/constants/api constants/api_constants.dart';
import '../model/trips_model.dart';

class TripsRemoteApiService {
  Future<List<TripsModel>?> fetchTripsApi(
      String? startingPoint, String? destination) async {
    try {
      List<TripsModel> tripslist = [];

      final response = await DioHelper.getAllData(
        url: '$tripsUrl?startingPoint=$startingPoint&destination=$destination',
        queryParameters: {},
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data != null && data is List) {
          for (var item in data) {
            if (item is Map<String, dynamic>) {
              tripslist.add(TripsModel.fromJson(item));
            } else {
              debugPrint('Unexpected item: $item');
            }
          }
          return tripslist;
        } else {
          debugPrint('Unexpected data structure: $data');
        }
      } else {
        debugPrint("Server error: ${response.statusCode}");
        return null;
      }
    } on DioException catch (error) {
      debugPrint("Dio error: $error");
      return null;
    } catch (e) {
      debugPrint("Unexpected error: $e");
      return null;
    }
  }
}
