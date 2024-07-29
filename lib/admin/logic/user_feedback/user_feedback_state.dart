part of 'user_feedback_cubit.dart';

sealed class UserFeedbackState extends Equatable {
  const UserFeedbackState();

  @override
  List<Object> get props => [];
}

final class UserFeedbackInitial extends UserFeedbackState {}

class AdminGetUserFeedbacksLoadingState extends UserFeedbackState{}

class AdminGetUserFeedbacksSuccessState extends UserFeedbackState {
  final List<UserFeedbackModel> feedbacksList;

  AdminGetUserFeedbacksSuccessState({required this.feedbacksList});

  @override
  List<Object> get props => [feedbacksList];
}

class AdminGetUserFeedbacksFailureState extends UserFeedbackState{
  AdminGetUserFeedbacksFailureState({required this.errorMessage});

  final String errorMessage;

    @override
  List<Object> get props => [errorMessage];
}
