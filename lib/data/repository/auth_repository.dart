import 'package:firebase_auth/firebase_auth.dart';

import '../providers/firebase_auth_providers.dart';

class AuthRepository {
  final FirebaseAuthProviders firebaseAuthProviders;

  AuthRepository({required this.firebaseAuthProviders});

  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    return await firebaseAuthProviders.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<User?> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    return await firebaseAuthProviders.signUpWithEmailAndPassword(
        email: email, password: password);
  }

  Future<User?> authWithGoogle() async {
    return await firebaseAuthProviders.authWithGoogle();
  }
}
