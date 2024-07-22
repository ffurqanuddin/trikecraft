import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trikecraft/data/repository/firestore_order_data_repository.dart';
import 'package:trikecraft/models/customization_order_model.dart';

part 'customized_bike_order_event.dart';
part 'customized_bike_order_state.dart';

class CustomizedBikeOrderBloc
    extends Bloc<CustomizedBikeOrderEvent, CustomizedBikeOrderState> {
  FirestoreOrdersDataRepository firestoreOrdersDataRepository;

  CustomizedBikeOrderBloc({required this.firestoreOrdersDataRepository})
      : super(CustomizedBikeOrderInitialState()) {
    on<SaveCustomizedBikeOrderDataEvent>(_saveCustomizedBikeOrderDataEvent);
    on<LoadCustomizedBikeOrderDataEvent>(_loadCustomizedBikeOrderDataEvent);
    on<CancelCustomizedBikeOrderDataEvent>(_cancelCustomizedBikeOrderDataEvent);
  }

  Future<FutureOr<void>> _saveCustomizedBikeOrderDataEvent(
      SaveCustomizedBikeOrderDataEvent event,
      Emitter<CustomizedBikeOrderState> emit) async {
    emit(CustomizedBikeOrderDataLoadingState());
    try {
      await firestoreOrdersDataRepository
          .saveCustomizedBikeOrderData(event.customizationOrderModel);
      emit(CustomizedBikeOrderDataSuccessfullySavedState());
    } catch (e) {
      emit(CustomizedBikeOrderDataSavingFailureState(
          errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _loadCustomizedBikeOrderDataEvent(
      LoadCustomizedBikeOrderDataEvent event,
      Emitter<CustomizedBikeOrderState> emit) async {

    emit(CustomizedBikeOrderDataLoadingState());
    try {
      final orders =
          await firestoreOrdersDataRepository.getCustomizedBikeOrderData();
      emit(CustomizedBikeOrderDataLoadedState(orders: orders));
    } catch (e) {
      emit(CustomizedBikeOrderDataLoadingFailureState(
          errorMessage: e.toString()));
    }
  }

  Future<FutureOr<void>> _cancelCustomizedBikeOrderDataEvent(
      CancelCustomizedBikeOrderDataEvent event,
      Emitter<CustomizedBikeOrderState> emit) async {
    emit(CustomizedBikeOrderDataCancelLoadingState());
    try {
      await firestoreOrdersDataRepository
          .cancelCustomizedBikeOrderData(event.orderId)
          .whenComplete(() {
        emit(CustomizedBikeOrderDataSuccessfullyCanceledState());
      }).onError(
        (error, stackTrace) {
          emit(CustomizedBikeOrderDataLoadingFailureState(
              errorMessage: error.toString()));
        },
      );
    } catch (e) {
      emit(CustomizedBikeOrderDataLoadingFailureState(
          errorMessage: e.toString()));
    }
  }
}
