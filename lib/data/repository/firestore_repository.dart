import 'package:trikecraft/data/providers/firestore_provider.dart';
import 'package:trikecraft/models/user_model.dart';

class FirestoreRepository {
  final FirestoreProvider firestoreProvider;
  

  FirestoreRepository({required this.firestoreProvider});
      

  // Save user data to Firestore
  Future<void> saveUser(UserModel user) async {
    try {
      await firestoreProvider.saveUserData(user: user);
    } catch (e) {
      print("Error in FirestoreRepository saving user: $e");
      // Handle the error accordingly
    }
  }

  // Retrieve user data from Firestore by document ID
  Future<UserModel?> getUserById(String userId) async {
    try {
      return await firestoreProvider.getUserDataById(userId);
    } catch (e) {
      print("Error in FirestoreRepository retrieving user by ID: $e");
      // Handle the error accordingly
    }
    return null;
  }

  // Retrieve all users from Firestore
  Future<List<UserModel>> getAllUsers() async {
    try {
      return await firestoreProvider.getAllUsers();
    } catch (e) {
      print("Error in FirestoreRepository retrieving all users: $e");
      // Handle the error accordingly
      return [];
    }
  }
}
