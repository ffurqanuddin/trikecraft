import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trikecraft/data/providers/bikes_data_provider.dart';
import 'package:trikecraft/models/bike_model.dart';

class BikesDataRepository {
  BikesDataRepository({required this.bikesDataProvider});
  final BikesDataProvider bikesDataProvider;

 Future<List<BikeModel>> getAvailableBikesFromFirestore() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snap =
          await bikesDataProvider.getAvailableBikesFromFirestore();
      return snap.docs.map((e) => BikeModel.fromFirestore(e.data())).toList();
      
    } catch (e) {
      throw Exception("Error While Fetching data in BikesDataRepository Class: $e");
    }
  }
}
