import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/customization_order_model.dart';
import '../../models/order_model.dart';

class FirestoreOrdersProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static const String customizedBikeOrder = "CustomizedBikeOrders";
  static const String newBikeOrder = "NewBikeOrders";

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

  // Save New Bike data to Firestore
  Future<void> saveNewBikeOrderData({required NewBikeOrderModel order}) async {
    try {
      await _firestore
          .collection(newBikeOrder)
          .doc(order.orderId)
          .set(order.toFirestore());
    } catch (e) {
      print("Error saving new bikes order data: $e");
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

  // Get Bike order data from Firestore
  Future<QuerySnapshot<Map<String, dynamic>>> getNewBikeOrderData() async {
    final userEmail = _firebaseAuth.currentUser?.email;
    if (userEmail == null) {
      throw Exception("No user logged in");
    }

    try {
      return await _firestore
          .collection(newBikeOrder)
          .where("userEmail", isEqualTo: userEmail)
          .get();
    } catch (e) {
      print("Error retrieving new bikes order data: $e");
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
