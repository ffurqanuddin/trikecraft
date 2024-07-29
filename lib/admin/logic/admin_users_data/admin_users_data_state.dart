part of 'admin_users_data_cubit.dart';

sealed class AdminUsersProfileDataState extends Equatable {
  const AdminUsersProfileDataState();

  @override
  List<Object> get props => [];
}

final class AdminUsersProfileDataInitialState
    extends AdminUsersProfileDataState {}

final class AdminUsersProfileDataLoadingState
    extends AdminUsersProfileDataState {}

final class AdminUsersProfileDataLoadedState
    extends AdminUsersProfileDataState {
  final List<UserModel> usersList;

  AdminUsersProfileDataLoadedState({required this.usersList});
}

final class AdminUsersProfileDataFailureState
    extends AdminUsersProfileDataState {
  final String errorMessage;

  AdminUsersProfileDataFailureState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
