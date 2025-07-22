part of 'stories_bloc.dart';

sealed class StoriesState {}

class StoriesInitial extends StoriesState {}

class StoriesLoading extends StoriesState {}

class StoriesFetchedState extends StoriesState {
  String message;
  StoriesFetchedState({
    required this.message,
  });
}

class StoriesFailureState extends StoriesState {
  String error;
  StoriesFailureState({
    required this.error,
  });
}
