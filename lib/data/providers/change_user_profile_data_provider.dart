import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trikecraft/base/services/hive/hive_services.dart';

class ChangeUserProfileDataProvider {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("Users");

  Future<void> changeUserProfileData(
      {required Map<String, dynamic> userData}) async {
    String userEmail =
        await MyHiveBoxes.settingBox.get(MyHiveKeys.userEmailHiveKey) ??
            FirebaseAuth.instance.currentUser?.email;
    await userCollection.doc(userEmail).set(userData);
  }
}
