import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trikecraft/admin/data/providers/admin_products_provider.dart';
import 'package:trikecraft/models/bike_model.dart';

class AdminProductsRepository {
  AdminProductsRepository({required this.adminProductsProvider});
  AdminProductsProvider adminProductsProvider;

  Future<List<BikeModel>> getAllProductsList() async {
    try {
      QuerySnapshot<Map<String, dynamic>> products =
          await adminProductsProvider.getAllProducts();
      return products.docs
          .map((e) => BikeModel.fromFirestore(e.data()))
          .toList();
    } catch (e) {
      print(e); // Handle the error appropriately, e.g., log it
      return []; // Return an empty list in case of error
    }
  }

  addNewProduct(
      { required BikeModel bikeModel}) async {
    try {
      await adminProductsProvider.addNewProduct(data: bikeModel.toFirestore(),orderId: bikeModel.bikeId);
    } catch (e) {
      print(e); // Handle the error appropriately, e.g., log it
    }
  }

  updateProduct(
      {required String bikeId, required BikeModel bikeModel}) async {
    try {
      await adminProductsProvider.updateProduct(bikeId: bikeId, data: bikeModel.toFirestore());
    } catch (e) {
      print(e); // Handle the error appropriately, e.g., log it
    }
  }

  deleteProduct({required String bikeId}) async {
    try {
      await adminProductsProvider.deleteProduct(bikeId: bikeId);
    } catch (e) {
      print(e); // Handle the error appropriately, e.g., log it
    }
  }
}
