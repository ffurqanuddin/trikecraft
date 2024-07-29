part of 'change_user_profile_cubit.dart';

sealed class ChangeUserProfileState extends Equatable {
  const ChangeUserProfileState();

  @override
  List<Object> get props => [];
}

final class ChangeUserProfileInitialState extends ChangeUserProfileState {}

final class ChangeUserProfileLoadingState extends ChangeUserProfileState {}

final class ChangeUserProfileSuccessfullyUpdatedState extends ChangeUserProfileState {}


final class ChangeUserProfileFailureState extends ChangeUserProfileState {
  final String errorMessage;

  ChangeUserProfileFailureState({required this.errorMessage});
}
