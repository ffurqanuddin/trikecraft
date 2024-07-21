import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trikecraft/models/user_model.dart';

import '../../data/repository/firestore_user_data_repository.dart';

part 'current_user_event.dart';
part 'current_user_state.dart';

class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {
  final FirestoreUserDataRepository firestoreRepository;
  CurrentUserBloc({required this.firestoreRepository})
      : super(CurrentUserInitialState()) {
    on<GetUserDataEvent>(_getUserDataEvent);
  }

  Future<FutureOr<void>> _getUserDataEvent(
      GetUserDataEvent event, Emitter<CurrentUserState> emit) async {
    emit(CurrentUserLoadingState());
    try {} catch (e) {
      emit(CurrentUserFailureState(errorMessage: e.toString()));
    }
  }
}
