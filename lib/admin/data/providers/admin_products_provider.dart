import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class AdminProductsProvider {


  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CollectionReference bikesCollection = FirebaseFirestore.instance.collection("bikes");
  

  getAllProducts() {
    return bikesCollection.get();
  }

  addNewProduct({required data, required String orderId}){
    
    bikesCollection.doc(orderId).set(data);
  }

  updateProduct({required String bikeId, required data}) {
    bikesCollection.doc(bikeId).update(data);
  }

  deleteProduct({
    required String bikeId,
  }) {
    bikesCollection.doc(bikeId).delete();
  }
}
