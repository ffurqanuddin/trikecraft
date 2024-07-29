import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({
    required this.fullName,
    required this.email,
    required this.profilePicture,
    required this.userId,
    required this.isAdmin,
  });

  final String fullName;
  final String email;
  final String profilePicture;
  final String userId;
  final bool isAdmin;
  

  // Factory method to create a UserModel from a Firestore document
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      fullName: data['fullName'] ?? '',
      email: data['email'] ?? '',
      profilePicture: data['profilePicture'] ?? '',
      userId: data['userId'] ?? '',
      isAdmin: data['isAdmin']?? false

    );
  }

  // Method to convert a UserModel to a Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'fullName': fullName,
      'email': email,
      'profilePicture': profilePicture,
      'userId': userId,
      'isAdmin': isAdmin
    };
  }
}
