import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trikecraft/admin/constant/order_status.dart';
import 'package:trikecraft/admin/data/repository/admin_orders_repository.dart';
import 'package:trikecraft/models/customization_order_model.dart';
import 'package:trikecraft/models/order_model.dart';

import '../../../models/feedback_model.dart';

part 'admin_state.dart';

class AdminCustomizableOrdersCubit extends Cubit<AdminCustomizableOrderState> {
  final AdminOrdersRepository adminOrdersRepository;

  AdminCustomizableOrdersCubit({required this.adminOrdersRepository})
      : super(AdminInitialState()) {
    // Start listening to real-time data streams when the cubit is created
    listenToRealTimeCustomizedBikeOrder();
    listenToRealTimeNewBikeOrder();
  }

  listenToRealTimeCustomizedBikeOrder() {
    emit(AdminLoadingState());
    try {
      emit(AdminGetListCustomizedOrderState(
          OrdersList: adminOrdersRepository.getAllCustomizedBikeOrderData()));
    } catch (e) {
      emit(AdminFailureState(errorMessage: e.toString()));
    }
  }

  listenToRealTimeNewBikeOrder() {
    emit(AdminLoadingState());
    try {
      emit(AdminGetListNewOrderState(
          OrdersList: adminOrdersRepository.getAllNewBikeOrderData()));
    } catch (e) {
      emit(AdminFailureState(errorMessage: e.toString()));
    }
  }

  Future<void> updateCustomizedBikeOrder({
    required String orderId,
    required Map<String, dynamic> data,
  }) async {
    try {
      emit(AdminLoadingState());
      await adminOrdersRepository.updateCustomizedBikeOrder(
          orderId: orderId, data: data);
      emit(AdminOrderDataIsSuccessfullyUpdatedState());
       emit(AdminGetListCustomizedOrderState(
          OrdersList: adminOrdersRepository.getAllCustomizedBikeOrderData()));
    } catch (e) {
      emit(AdminFailureState(errorMessage: e.toString()));
    }
  }
}
