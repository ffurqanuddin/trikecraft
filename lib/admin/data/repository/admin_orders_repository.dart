import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trikecraft/models/user_model.dart';

import '../../../models/customization_order_model.dart';
import '../../../models/feedback_model.dart';
import '../../../models/order_model.dart';
import '../providers/admin_orders_providers.dart';

class AdminOrdersRepository {
  final AdminOrdersProvider adminOrdersProvider;

  AdminOrdersRepository({required this.adminOrdersProvider});

  // Retrieve customized bike order data as a stream
  Stream<List<CustomizationOrderModel>> getAllCustomizedBikeOrderData() {
    return adminOrdersProvider.getAllCustomizedBikeOrderData().map(
      (snapshot) {
        return snapshot.docs
            .map((doc) => CustomizationOrderModel.fromFirestore(doc.data()))
            .toList();
      },
    ).handleError((error) {
      print("Error retrieving customized bikes order data: $error");
      return []; // Return an empty list in case of error
    });
  }

  // Retrieve new bike order data as a stream
  Stream<List<NewOrderModel>> getAllNewBikeOrderData() {
    return adminOrdersProvider.getAllNewBikeOrderData().map(
      (snapshot) {
        return snapshot.docs
            .map((doc) => NewOrderModel.fromFirestore(doc.data()))
            .toList();
      },
    ).handleError((error) {
      print("Error retrieving new bikes order data: $error");
      return []; // Return an empty list in case of error
    });
  }

  Future<void> cancelCustomizedBikeOrderData(String orderId) async {
    try {
      await adminOrdersProvider.cancelCustomizedBikeOrderData(orderId: orderId);
    } catch (e) {
      print("Error deleting/canceling customized bikes order data: $e");
    }
  }

  Future<void> updateCustomizedBikeOrder({
    required String orderId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await adminOrdersProvider.updateCustomizedBikeOrder(
          orderId: orderId, data: data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<UserFeedbackModel>> getUsersFeedbacksList() async {
    try {
      QuerySnapshot<Map<String, dynamic>> feedbacks =
          await adminOrdersProvider.getUsersFeedbacksList();
      return feedbacks.docs
          .map((e) => UserFeedbackModel.fromMap(e.data()))
          .toList();
    } catch (e) {
      print(e); // Handle the error appropriately, e.g., log it
      return []; // Return an empty list in case of error
    }
  }

  Future<List<UserModel>> getUsersDataList() async {
    try {
      QuerySnapshot<Map<String, dynamic>> users =
          await adminOrdersProvider.getUsersDataList();
      return users.docs
          .map(
            (e) => UserModel.fromFirestore(e),
          )
          .toList();
    } catch (e) {
      print(e); // Handle the error appropriately, e.g., log it
      return []; // Return an empty list in case of error
    }
  }
}
