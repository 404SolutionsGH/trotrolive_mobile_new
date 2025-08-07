import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import '../repository/data/stories_service.dart';
import '../repository/model/stories_model.dart';

part 'stories_event.dart';
part 'stories_state.dart';

class StoriesBloc extends Bloc<StoriesEvent, StoriesState> {
  static const String _cacheKey = 'cached_stories';
  static const String _cacheTimeKey = 'cached_stories_time';
  static const Duration _cacheDuration = Duration(minutes: 2);
  late final SharedPreferences _prefs;

  StoriesBloc() : super(StoriesInitial()) {
    on<FetchStoriesEvent>(_onFetchStories);
    _initPreferences();
  }

  Future<void> _initPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _onFetchStories(
    FetchStoriesEvent event,
    Emitter<StoriesState> emit,
  ) async {
    emit(StoriesLoading());

    try {
      if (!event.forceRefresh) {
        final cachedStories = await _getCachedStories();
        if (cachedStories != null) {
          emit(StoriesFetchedState(
            stories: cachedStories,
            message: 'Loaded from cache',
          ));
        }
      }

      final freshStories = await StoryService.fetchStories(limit: 50);
      await _cacheStories(freshStories);

      emit(StoriesFetchedState(
        stories: freshStories,
        message: 'Successfully fetched',
      ));
    } on DioException catch (e) {
      emit(StoriesFailureState(
        error: 'Network error: ${e.message}',
      ));
    } catch (e) {
      emit(StoriesFailureState(
        error: 'Unexpected error: $e',
      ));
    }
  }

  Future<StoryResponse?> _getCachedStories() async {
    try {
      final cachedData = _prefs.getString(_cacheKey);
      if (cachedData == null) return null;

      final cacheTime = _prefs.getString(_cacheTimeKey);
      if (cacheTime != null) {
        final cachedAt = DateTime.parse(cacheTime);
        if (DateTime.now().difference(cachedAt) > _cacheDuration) {
          return null;
        }
      }

      return StoryResponse.fromJson(jsonDecode(cachedData));
    } catch (_) {
      return null;
    }
  }

  Future<void> _cacheStories(StoryResponse stories) async {
    await _prefs.setString(_cacheKey, jsonEncode(stories.toJson()));
    await _prefs.setString(_cacheTimeKey, DateTime.now().toIso8601String());
  }
}
