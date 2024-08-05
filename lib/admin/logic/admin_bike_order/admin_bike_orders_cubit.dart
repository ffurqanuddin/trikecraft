import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/streams.dart';
import 'package:trikecraft/admin/data/repository/admin_orders_repository.dart';
import 'package:trikecraft/models/customization_order_model.dart';
import 'package:trikecraft/models/order_model.dart';

part 'admin_state.dart';

class AdminBikeOrdersCubit extends Cubit<AdminBikeOrderState> {
  final AdminOrdersRepository adminOrdersRepository;

  AdminBikeOrdersCubit({required this.adminOrdersRepository})
      : super(AdminInitialState()) {
    listenToRealTimeOrders();
  }

 void listenToRealTimeOrders() {
    emit(AdminLoadingState());

    CombineLatestStream.combine2<List<CustomizationOrderModel>, List<NewBikeOrderModel>, Map<String, List<Object>>>(
      adminOrdersRepository.getAllCustomizedBikeOrderData(),
      adminOrdersRepository.getAllNewBikeOrderData(),
      (customizedOrders, newOrders) {
        return {
          'customizedOrders': customizedOrders,
          'newOrders': newOrders,
        };
      },
    ).listen((combinedOrders) {
      emit(AdminGetCombinedOrdersState(
        customizedOrders: Stream<List<CustomizationOrderModel>>.value(combinedOrders['customizedOrders'] as List<CustomizationOrderModel>).asBroadcastStream(),
        newOrders: Stream<List<NewBikeOrderModel>>.value(combinedOrders['newOrders'] as List<NewBikeOrderModel>).asBroadcastStream(),
      ));
    }, onError: (e) {
      emit(AdminFailureState(errorMessage: e.toString()));
    });
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
      listenToRealTimeOrders(); // Refresh data after update
    } catch (e) {
      emit(AdminFailureState(errorMessage: e.toString()));
    }
  }

  Future<void> updateNewBikeOrder({
    required String orderId,
    required Map<String, dynamic> data,
  }) async {
    try {
      emit(AdminLoadingState());
      await adminOrdersRepository.updateNewBikeOrder(
          orderId: orderId, data: data);
      emit(AdminOrderDataIsSuccessfullyUpdatedState());
      listenToRealTimeOrders(); // Refresh data after update
    } catch (e) {
      emit(AdminFailureState(errorMessage: e.toString()));
    }
  }
}