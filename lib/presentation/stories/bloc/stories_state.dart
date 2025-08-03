part of 'stories_bloc.dart';

sealed class StoriesState {}

class StoriesInitial extends StoriesState {}

class StoriesLoading extends StoriesState {}

class StoriesFetchedState extends StoriesState {
  final StoryResponse stories;
  final String message;

  StoriesFetchedState({
    required this.stories,
    required this.message,
  });
}

class StoriesFailureState extends StoriesState {
  final String error;

  StoriesFailureState({
    required this.error,
  });
}
