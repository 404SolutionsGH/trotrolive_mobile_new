import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:trotrolive_mobile_new/utils/constants/api%20constants/api_constants.dart';
import '../../../../data/dio/dio_helper.dart';
import '../model/stories_model.dart';
import 'cache_manager.dart';

class StoryService {
  static Future<StoryResponse> fetchStories({
    int page = 1,
    int limit = 50,
    String? sourceFilter,
    CancelToken? cancelToken,
  }) async {
    final requestUrl = storiesUrl;
    final queryParams = {
      'page': page,
      'limit': limit,
      if (sourceFilter != null) 'source': sourceFilter,
    };

    try {
      final response = await DioHelper.getAllData(
        url: requestUrl,
        queryParameters: queryParams,
      );

      return StoryResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleStoryError(e);
    }
  }

  static Future<Story> fetchStoryById(String id) async {
    final requestUrl = storiesUrl;

    final response = await DioHelper.getAllData(
      url: requestUrl,
      queryParameters: {},
    );

    return Story.fromJson(response.data);
  }

  static Exception _handleStoryError(DioException e) {
    final statusCode = e.response?.statusCode;
    final errorData = e.response?.data;

    switch (statusCode) {
      case 400:
        return Exception('Invalid request: ${errorData['error']}');
      case 401:
        return Exception('Authentication failed');
      case 404:
        return Exception('Stories not found');
      case 500:
        return Exception('Server error: ${errorData['error']}');
      default:
        return Exception('Network error: ${e.message}');
    }
  }

  static Future<StoryResponse> fetchHomepageStories({
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh) {
      final cachedStories = await CacheManager.getStories();
      if (cachedStories != null) {
        debugPrint('Returning cached stories');
        return cachedStories;
      }
    }

    debugPrint('Fetching fresh stories');
    final response = await DioHelper.getAllData(
      url: storiesUrl,
      queryParameters: {'limit': '4'},
    );

    final stories = StoryResponse.fromJson(response.data);
    await CacheManager.saveStories(stories);

    return stories;
  }
}
