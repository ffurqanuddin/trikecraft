import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/customization_order_model.dart';

class FirestoreOrdersProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static const String customizedBikeOrder = "CustomizedBikeOrders";

  // Save Bike data to Firestore
  Future<void> saveCustomizedBikeOrderData(
      {required CustomizationOrderModel order}) async {
    try {
      await _firestore
          .collection(customizedBikeOrder)
          .doc(order.orderId)
          .set(order.toFirestore());
    } catch (e) {
      print("Error saving customized bikes order data: $e");
      // Handle the error accordingly
    }
  }

  // Get Bike order data from Firestore
  Future<QuerySnapshot<Map<String, dynamic>>>
      getCustomizedBikeOrderData() async {
    final userEmail = _firebaseAuth.currentUser?.email;
    if (userEmail == null) {
      throw Exception("No user logged in");
    }

    try {
      return await _firestore
          .collection(customizedBikeOrder)
          .where("userEmail", isEqualTo: userEmail)
          .get();

    } catch (e) {
      print("Error retrieving customized bikes order data: $e");
      // Handle the error accordingly
      throw e; // rethrow the exception after logging
    }
  }

  // Cancel Bike order data from Firestore
  Future<void> cancelCustomizedBikeOrderData({required String orderId}) async {
    try {
      await _firestore.collection(customizedBikeOrder).doc(orderId).delete();
    } catch (e) {
      print("Error deleting customized bikes order data: $e");
      // Handle the error accordingly
      throw e; // rethrow the exception after logging
    }
  }
}
