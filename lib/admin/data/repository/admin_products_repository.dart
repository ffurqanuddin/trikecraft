import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trikecraft/admin/data/providers/admin_products_provider.dart';
import 'package:trikecraft/models/bike_model.dart';

class AdminProductsRepository {
  AdminProductsProvider _adminProductsProvider = AdminProductsProvider();

  Future<List<BikeModel>> getAllProductsList() async {
    try {
      QuerySnapshot<Map<String, dynamic>> products =
          await _adminProductsProvider.getAllProducts();
      return products.docs
          .map((e) => BikeModel.fromFirestore(e.data()))
          .toList();
    } catch (e) {
      print(e); // Handle the error appropriately, e.g., log it
      return []; // Return an empty list in case of error
    }
  }
}
