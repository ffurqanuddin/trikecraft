part of 'current_user_bloc.dart';

sealed class CurrentUserEvent extends Equatable {
  const CurrentUserEvent();

  @override
  List<Object> get props => [];
}

class GetUserDataEvent extends CurrentUserEvent {}

class UpdateUserDataEvent extends CurrentUserEvent {}

class ChangeUserProfilePicture extends CurrentUserEvent {}
