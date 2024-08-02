import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/repository/firestore_order_data_repository.dart';
import 'new_bike_order_event.dart';
import 'new_bike_order_state.dart';


class NewBikeOrderBloc
    extends Bloc<NewBikeOrderEvent, NewBikeOrderState> {
  FirestoreOrdersDataRepository firestoreOrdersDataRepository;

  NewBikeOrderBloc({required this.firestoreOrdersDataRepository})
      : super(NewBikeOrderInitialState()) {
    on<SaveNewBikeOrderDataEvent>(_saveNewBikeOrderDataEvent);
    on<LoadNewBikeOrderDataEvent>(_loadNewBikeOrderDataEvent);
  }

  Future<FutureOr<void>> _saveNewBikeOrderDataEvent(
      SaveNewBikeOrderDataEvent event,
      Emitter<NewBikeOrderState> emit) async {
    emit(NewBikeOrderDataLoadingState());
    try {
      await firestoreOrdersDataRepository
          .saveNewBikeOrderData(event.newOrderModel);
      emit(NewBikeOrderDataSuccessfullySavedState());
    } catch (e) {
      emit(NewBikeOrderDataSavingFailureState(
          errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _loadNewBikeOrderDataEvent(
      LoadNewBikeOrderDataEvent event,
      Emitter<NewBikeOrderState> emit) async {

    emit(NewBikeOrderDataLoadingState());
    try {
      final orders =
          await firestoreOrdersDataRepository.getNewBikeOrderData();
      emit(NewBikeOrderDataLoadedState(orders: orders));
    } catch (e) {
      emit(NewBikeOrderDataLoadingFailureState(
          errorMessage: e.toString()));
    }
  }


}