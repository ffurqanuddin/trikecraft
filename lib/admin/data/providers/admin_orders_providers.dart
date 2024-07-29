import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminOrdersProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static const String customizedBikeOrder = "CustomizedBikeOrders";
  static const String newBikeOrder = "NewBikeOrders";
  static const String userFeedbacks = "feedbacks";
  static const String users = "Users";


  // Get Bike order data from Firestore
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllCustomizedBikeOrderData() {
    return _firestore.collection(customizedBikeOrder).snapshots();
  }

  // Get Bike order data from Firestore
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllNewBikeOrderData() {
    return _firestore.collection(newBikeOrder).snapshots();
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
        .collection('CustomizedBikeOrders')
        .doc(orderId)
        .update(data);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUsersFeedbacksList() async {
    return await _firestore.collection(userFeedbacks).get();
  }


  Future<QuerySnapshot<Map<String, dynamic>>> getUsersDataList() async {
    return await _firestore.collection(users).get();
  }
}
