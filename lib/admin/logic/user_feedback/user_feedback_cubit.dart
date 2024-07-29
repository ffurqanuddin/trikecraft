import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trikecraft/models/feedback_model.dart';

import '../../data/repository/admin_orders_repository.dart';

part 'user_feedback_state.dart';

class AdminUserFeedbackCubit extends Cubit<UserFeedbackState> {
  final AdminOrdersRepository adminOrdersRepository;
  AdminUserFeedbackCubit({required this.adminOrdersRepository})
      : super(UserFeedbackInitial());

  Future<void> getUsersFeedbacksList() async {
    try {
      emit(AdminGetUserFeedbacksLoadingState());
      final feedbacksList = await adminOrdersRepository.getUsersFeedbacksList();
      emit(AdminGetUserFeedbacksSuccessState(feedbacksList: feedbacksList));
    } catch (e) {
      emit(AdminGetUserFeedbacksFailureState(errorMessage: e.toString()));
    }
  }
}
