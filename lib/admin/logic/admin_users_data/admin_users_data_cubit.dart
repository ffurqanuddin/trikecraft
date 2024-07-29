import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/user_model.dart';
import '../../data/repository/admin_orders_repository.dart';

part 'admin_users_data_state.dart';

class AdminUsersProfileDataCubit extends Cubit<AdminUsersProfileDataState> {
  final AdminOrdersRepository adminOrdersRepository;
  AdminUsersProfileDataCubit({required this.adminOrdersRepository})
      : super(AdminUsersProfileDataInitialState());

  Future<void> getUsersDataList() async {
    emit(AdminUsersProfileDataLoadingState());
    try {
      final usersList = await adminOrdersRepository.getUsersDataList();

      emit(AdminUsersProfileDataLoadedState(usersList: usersList));
    } catch (e) {
      emit(AdminUsersProfileDataFailureState(errorMessage: e.toString()));
    }
  }
}
