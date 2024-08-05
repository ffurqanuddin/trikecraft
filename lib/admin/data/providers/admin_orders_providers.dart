import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminOrdersProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String customizedBikeOrder = "CustomizedBikeOrders";
  static const String newBikeOrder = "NewBikeOrders";
  static const String userFeedbacks = "feedbacks";
  static const String users = "Users";

  // Get Bike order data from Firestore in descending order
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllCustomizedBikeOrderData() {
    return _firestore.collection(customizedBikeOrder)
      .orderBy('orderDate', descending: true)
      .snapshots();
  }

  // Get New Bike order data from Firestore in descending order
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllNewBikeOrderData() {
    return _firestore.collection(newBikeOrder)
      .orderBy('orderDate', descending: true)
      .snapshots();
  }

  // Cancel Bike order data from Firestore
  Future<void> cancelCustomizedBikeOrderData({required String orderId}) async {
    await _firestore.collection(customizedBikeOrder).doc(orderId).delete();
  }

  Future<void> updateCustomizedBikeOrder({
    required String orderId,
    required Map<String, dynamic> data,
  }) async {
    await _firestore
        .collection(customizedBikeOrder)
        .doc(orderId)
        .update(data);
  }

  Future<void> updateNewBikeOrder({
    required String orderId,
    required Map<String, dynamic> data,
  }) async {
    await _firestore
        .collection(newBikeOrder)
        .doc(orderId)
        .update(data);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUsersFeedbacksList() async {
    return await _firestore.collection(userFeedbacks).orderBy('date', descending: true).get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUsersDataList() async {
    return await _firestore.collection(users)
      .orderBy('fullName') // Sort by the 'fullName' field in ascending order
      .get();
  }
}
