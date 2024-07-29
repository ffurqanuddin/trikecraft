import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trikecraft/models/feedback_model.dart';
import 'package:trikecraft/presentation/home/widgets/error_message.dart';

import '../../data/repository/firestore_user_data_repository.dart';

part 'user_feedback_state.dart';

class UserFeedbackCubit extends Cubit<UserFeedbackState> {
  FirestoreUserDataRepository firestoreUserDataRepository;
  UserFeedbackCubit({required this.firestoreUserDataRepository})
      : super(UserFeedbackInitialState());

  Future<void> submitFeedback({required UserFeedbackModel feedback}) async {
    emit(UserFeedbackLoadingState());
    try {
      firestoreUserDataRepository
          .saveUserFeedback(feedback: feedback)
          .whenComplete(() {
        emit(UserFeedbackSubmittedState());
      });
    } catch (e) {
      emit(UserFeedbackFailureState(errorMessage: e.toString()));
    }
  }
}
