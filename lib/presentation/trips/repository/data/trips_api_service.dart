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
        var jsonString = jsonDecode(response.data);
        var tripList = jsonString['Trips'];

        if (tripList != null && tripList is Iterable) {
          for (Map<String, dynamic> item in tripList) {
            tripslist.add(TripsModel.fromJson(item));
          }
          return tripslist;
        } else {
          debugPrint('Invalid data format. Response body: $jsonString');
        }
      } else {
        debugPrint("error:  ${response.statusCode}");
        return null;
      }
    } on DioException catch (error) {
      debugPrint(error.toString());
      throw Error;
    }
  }
}
