import 'package:cloud_firestore/cloud_firestore.dart';

class BikesDataProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _bikesCollection = 'bikes';

  Future<QuerySnapshot<Map<String, dynamic>>>
      getAvailableBikesFromFirestore() async {
    return await _firestore.collection(_bikesCollection).get();
  }
  
}
