part of 'stories_bloc.dart';

sealed class StoriesEvent {}

class FetchStoriesEvent extends StoriesEvent {
  final bool forceRefresh;

  FetchStoriesEvent({this.forceRefresh = false});
}
