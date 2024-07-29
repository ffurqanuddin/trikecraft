import 'package:trikecraft/data/providers/firestore_user_data_provider.dart';
import 'package:trikecraft/models/user_model.dart';

import '../../models/feedback_model.dart';

class FirestoreUserDataRepository {
  final FirestoreUserDataProvider firestoreProvider;

  FirestoreUserDataRepository({required this.firestoreProvider});

  // Save user data to Firestore
  Future<void> addNewUser(UserModel user) async {
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

  // Retrieve user data from Firestore by document ID
  Future<UserModel?> getCurrentUserData() async {
    try {
      return await firestoreProvider.getCurrentUserData();
    } catch (e) {
      print("Error in FirestoreRepository retrieving Current User Data: $e");
      // Handle the error accordingly
    }
    return null;
  }

  // check user is admin
  Future<bool> checkUserIsAdmin() async {
    return await firestoreProvider.checkUserIsAdmin();
  }

  Future<void> saveUserFeedback({required UserFeedbackModel feedback}) async {
    try {
      await firestoreProvider.saveUserFeedback(feedback: feedback);
    } catch (e) {
      throw Exception(e);
    }
  }
}
