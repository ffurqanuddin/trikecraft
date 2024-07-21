import 'package:trikecraft/models/customization_order_model.dart';

import '../providers/firestore_orders_provider.dart';

class FirestoreOrdersDataRepository {
  final FirestoreOrdersProvider firestoreOrdersProvider;

  FirestoreOrdersDataRepository({required this.firestoreOrdersProvider});

  // Save user data to Firestore
  Future<void> saveCustomizedBikeOrderData(
      CustomizationOrderModel order) async {
    try {
      await firestoreOrdersProvider.saveCustomizedBikeOrderData(order: order);
    } catch (e) {
      print("Error in FirestoreRepository saving order: $e");
      // Handle the error accordingly
    }
  }

  // Retrieve customized bike order data
  Future<List<CustomizationOrderModel>> getCustomizedBikeOrderData() async {
    try {
      final snapshot =
          await firestoreOrdersProvider.getCustomizedBikeOrderData();
      return snapshot.docs
          .map((doc) => CustomizationOrderModel.fromFirestore(doc.data()))
          .toList();
    } catch (e) {
      print("Error retrieving customized bikes order data: $e");
      return [];
    }
  }

  Future<void> cancelCustomizedBikeOrderData(orderId) async {
    try {
      firestoreOrdersProvider.cancelCustomizedBikeOrderData(orderId: orderId);
    } catch (e) {
       print("Error deleting/canceling customized bikes order data: $e");
    }
  }
}
