import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../presentation/stations/repository/model/stations_model.dart';

class StationCacheHelper {
  static const String _cacheKey = 'cached_stations';

  static Future<void> cacheStations(List<StationModel> stations) async {
    final prefs = await SharedPreferences.getInstance();
    final stationListJson =
        stations.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList(_cacheKey, stationListJson);
  }

  static Future<List<StationModel>> getCachedStations() async {
    final prefs = await SharedPreferences.getInstance();
    final stationJsonList = prefs.getStringList(_cacheKey);

    if (stationJsonList == null) return [];
    return stationJsonList
        .map((jsonStr) => StationModel.fromJson(jsonDecode(jsonStr)))
        .toList();
  }

  static Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cacheKey);
  }
}
