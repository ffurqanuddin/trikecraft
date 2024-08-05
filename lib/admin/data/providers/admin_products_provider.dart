import 'package:cloud_firestore/cloud_firestore.dart';

class AdminProductsProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const bikesCollection = "bikes";

  getAllProducts() {
    return _firestore.collection(bikesCollection).get();
  }
}
