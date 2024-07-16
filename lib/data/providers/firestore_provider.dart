import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trikecraft/models/user_model.dart';

class FirestoreProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String usersCollection = "Users";

  // Save user data to Firestore
  Future<void> saveUserData({required UserModel user}) async {
    try {
      await _firestore.collection(usersCollection).add(user.toFirestore());
    } catch (e) {
      print("Error saving user data: $e");
      // Handle the error accordingly
    }
  }

  // Retrieve user data from Firestore by document ID
  Future<UserModel?> getUserDataById(String userId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection(usersCollection).doc(userId).get();
      if (doc.exists) {
        return UserModel.fromFirestore(doc);
      }
    } catch (e) {
      print("Error retrieving user data: $e");
      // Handle the error accordingly
    }
    return null;
  }

  // Retrieve all users from Firestore
  Future<List<UserModel>> getAllUsers() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection(usersCollection).get();
      return querySnapshot.docs.map((doc) => UserModel.fromFirestore(doc)).toList();
    } catch (e) {
      print("Error retrieving all users: $e");
      // Handle the error accordingly
      return [];
    }
  }
}
