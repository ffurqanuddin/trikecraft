import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:trikecraft/base/services/hive/hive_services.dart';
import 'package:trikecraft/models/bike_model.dart';
import 'package:trikecraft/models/order_model.dart';
import 'package:trikecraft/models/p2p_payment_model.dart';
import 'package:trikecraft/utils/delievery_date_extension.dart';
import 'package:trikecraft/utils/generate_unique_order_id.dart';

import '../new_bike_order/new_bike_order_bloc.dart';
import '../new_bike_order/new_bike_order_event.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitialState());

  // Payment-related fields
  late String transactionId;
  late String senderName;
  late String contactInfo;
  late String paymentMethod;
  late String accountName;
  late String amount;
  late DateTime transactionDate;
  late String transactionStatus;

  // Order-related fields
  late String orderId;
  late String userName;
  late String userEmail;
  late BikeModel bike;
  late DateTime orderDate;
  late DateTime deliveryDate;
  late String orderStatus;

  Future<void> initializePaymentDetails({
    required String transactionId,
    required String senderName,
    required String contactInfo,
    required String paymentMethod,
    required String accountName,
    required String amount,
    required BikeModel bike,
  }) async {
    this.transactionId = transactionId;
    this.senderName = senderName;
    this.contactInfo = contactInfo;
    this.paymentMethod = paymentMethod;
    this.accountName = accountName;
    this.amount = amount;
    this.transactionDate = DateTime.now();
    this.transactionStatus = 'Pending';

    // Additional order initialization
    this.bike = bike;
    orderId = await _genOrderId();
    userName = await _getUserName;
    userEmail = await _getUserEmail;
    orderDate = DateTime.now();
    deliveryDate = orderDate.deliveryDate;
    orderStatus = 'Pending';
  }

  Future<void> payWithP2P(BuildContext context) async {
    emit(PaymentLoadingState());
    await _genOrderId();
    await _getUserName;
    await _getUserEmail;

    try {
      P2PPaymentModel p2pModel = P2PPaymentModel(
        transactionId: transactionId,
        senderName: senderName,
        contactInfo: contactInfo,
        paymentMethod: paymentMethod,
        accountName: accountName,
        amount: amount,
        transactionDate: transactionDate,
        transactionStatus: transactionStatus,
      );

      NewBikeOrderModel order = NewBikeOrderModel(
        orderId: orderId,
        userName: userName,
        userEmail: userEmail,
        bike: bike,
        orderDate: orderDate,
        deliveryDate: deliveryDate,
        orderStatus: orderStatus,
        paymentDetails: p2pModel,
      );

      context
          .read<NewBikeOrderBloc>()
          .add(SaveNewBikeOrderDataEvent(newOrderModel: order));

      emit(PaymentSuccessState());
    } catch (e) {
      emit(PaymentFailureState(message: e.toString()));
    }
  }

  Future<String> _genOrderId() async {
    String email =
        await MyHiveBoxes.settingBox.get(MyHiveKeys.userEmailHiveKey);
    return generateOrderId(email);
  }

  Future<String> get _getUserName async =>
      await MyHiveBoxes.settingBox.get(MyHiveKeys.userNameHiveKey);

  Future<String> get _getUserEmail async =>
      await MyHiveBoxes.settingBox.get(MyHiveKeys.userEmailHiveKey);
}
