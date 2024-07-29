part of 'user_feedback_cubit.dart';

sealed class UserFeedbackState extends Equatable {
  const UserFeedbackState();

  @override
  List<Object> get props => [];
}

final class UserFeedbackInitialState extends UserFeedbackState {}
final class UserFeedbackLoadingState extends UserFeedbackState {}
final class UserFeedbackSubmittedState extends UserFeedbackState {}
final class UserFeedbackFailureState extends UserFeedbackState {

  final String errorMessage;

  UserFeedbackFailureState({required this.errorMessage});
    @override
  List<Object> get props => [errorMessage];
}
