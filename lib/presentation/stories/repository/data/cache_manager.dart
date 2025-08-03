import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/stories_model.dart';

class CacheManager {
  static const String _storiesKey = 'cached_stories';
  static const String _timestampKey = 'stories_timestamp';
  static const Duration _cacheDuration = Duration(hours: 1);

  /// Save stories to cache
  static Future<void> saveStories(StoryResponse stories) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storiesKey, jsonEncode(stories.toJson()));
    await prefs.setString(_timestampKey, DateTime.now().toIso8601String());
  }

  /// Get cached stories if valid
  static Future<StoryResponse?> getStories() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(_storiesKey);
    final timestamp = prefs.getString(_timestampKey);

    if (cachedData == null || timestamp == null) return null;

    final cachedAt = DateTime.parse(timestamp);
    if (DateTime.now().difference(cachedAt) > _cacheDuration) {
      return null; // Cache expired
    }

    return StoryResponse.fromJson(jsonDecode(cachedData));
  }

  /// Clear cached stories
  static Future<void> clearStories() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storiesKey);
    await prefs.remove(_timestampKey);
  }
}
