part of 'current_user_bloc.dart';

sealed class CurrentUserState extends Equatable {
  const CurrentUserState();

  @override
  List<Object> get props => [];
}

final class CurrentUserInitialState extends CurrentUserState {}

final class CurrentUserLoadingState extends CurrentUserState {}

final class CurrentUserSuccessState extends CurrentUserState {
  @override
  List<Object> get props => [];
}

final class CurrentUserFailureState extends CurrentUserState {
  final String errorMessage;

  CurrentUserFailureState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

final class CurrentUserProfileSuccessfullyUpdatedState
    extends CurrentUserState {}
