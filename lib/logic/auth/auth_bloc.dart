import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:one_context/one_context.dart';
import 'package:trikecraft/base/routes/app_routes.dart';
import 'package:trikecraft/base/services/hive/hive_services.dart';
import 'package:trikecraft/data/repository/auth_repository.dart';
import 'package:trikecraft/data/repository/firestore_user_data_repository.dart';
import 'package:trikecraft/models/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final FirestoreUserDataRepository firestoreRepository;

  AuthBloc({required this.authRepository, required this.firestoreRepository})
      : super(AuthInitialState()) {
    on<SignInWithEmailEvent>(_signInWithEmail);
    on<SignUpWithEmailEvent>(_signUpWithEmail);
    on<AuthWithGoogleEvent>(_authWithGoogle);
    on<LogOutEvent>(_logOutEvent);
  }

  //--------------------- Sign In With Email --------------------------///
  FutureOr<void> _signInWithEmail(
      SignInWithEmailEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      // Attempt to sign in the user
      final User? user = await authRepository.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      if (user != null) {
        await _handleSuccessfulSignIn(user, event.email);
        emit(AuthSuccessState());
        
      } else {
        emit(AuthFailureState(errorMessage: 'Sign in failed'));
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthFailureState(errorMessage: _getFirebaseAuthErrorMessage(e)));
    } catch (e) {
      emit(AuthFailureState(errorMessage: 'An unexpected error occurred'));
    }
  }

  Future<void> _handleSuccessfulSignIn(User user, String email) async {
    if (await firestoreRepository.checkUserIsAdmin()) {
      await _setAdminPreferences();
    } else {
      await MyHiveBoxes.settingBox.put(MyHiveKeys.userIsLoggedIn, true);
    }

    UserModel? userData = await firestoreRepository.getCurrentUserData();
    await _saveUserDataToLocalStorage(userData, email);
  }

  Future<void> _setAdminPreferences() async {
    await MyHiveBoxes.settingBox.put(MyHiveKeys.isAdminLoggedIn, true);
    await MyHiveBoxes.settingBox.put(MyHiveKeys.darkModeHiveKey, true);
  }

  Future<void> _saveUserDataToLocalStorage(
      UserModel? user, String email) async {
    await MyHiveBoxes.settingBox.put(MyHiveKeys.userEmailHiveKey, email);
    await MyHiveBoxes.settingBox
        .put(MyHiveKeys.userNameHiveKey, user?.fullName ?? "User");
    await MyHiveBoxes.settingBox
        .put(MyHiveKeys.userProfilePicHiveKey, user?.profilePicture);
  }

  String _getFirebaseAuthErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-credential':
        return 'User is not registered';
      case 'invalid-email':
        return 'The email address is not valid';
      case 'user-disabled':
        return 'The user has been disabled';
      case 'user-not-found':
        return 'No user found for this email';
      case 'wrong-password':
        return 'The password is incorrect';
      default:
        return 'An authentication error occurred';
    }
  }

  //--------------------- Sign Up With Email --------------------------///
  FutureOr<void> _signUpWithEmail(
      SignUpWithEmailEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      // Attempt to sign up the user with the provided email and password
      final userData = await authRepository.signUpWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      // If sign-up is successful, save the user data to Firestore
      if (userData != null) {
        final user = UserModel(
            fullName: event.fullName,
            email: event.email,
            profilePicture: event.profilePicture,
            userId: userData.uid.toString(),
            isAdmin: false);
        await firestoreRepository.addNewUser(user);

        await MyHiveBoxes.settingBox
            .put(MyHiveKeys.userNameHiveKey, event.fullName);
        await MyHiveBoxes.settingBox
            .put(MyHiveKeys.userEmailHiveKey, event.email);
        await MyHiveBoxes.settingBox
            .put(MyHiveKeys.userProfilePicHiveKey, event.profilePicture);

        // Set the user as logged in using Hive storage
        await MyHiveBoxes.settingBox.put(MyHiveKeys.userIsLoggedIn, true);
        emit(AuthSuccessState());

      } else {
        // If sign-up fails, emit failure state with an error message
        emit(AuthFailureState(errorMessage: 'Sign up failed'));
      }
    } catch (e) {
      // If there is an exception, emit failure state with the exception message
      emit(AuthFailureState(errorMessage: e.toString()));
      OneContext().pop();
    }
  }

  //---------------------  Authentication With Google --------------------------///
  FutureOr<void> _authWithGoogle(
      AuthWithGoogleEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      final user = await authRepository.authWithGoogle();

      if (user != null) {
        String dummyPic =
            "https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg";

        final userData = UserModel(
            fullName: user.displayName ?? "User",
            email: user.email ?? "email",
            profilePicture: user.photoURL ?? dummyPic,
            userId: user.uid,
            isAdmin: false);

        await firestoreRepository.addNewUser(userData);
        await MyHiveBoxes.settingBox.put(MyHiveKeys.userIsLoggedIn, true);
        await MyHiveBoxes.settingBox
            .put(MyHiveKeys.userNameHiveKey, user.displayName ?? "User");
        await MyHiveBoxes.settingBox
            .put(MyHiveKeys.userEmailHiveKey, user.email ?? "Email");
        await MyHiveBoxes.settingBox
            .put(MyHiveKeys.userProfilePicHiveKey, user.photoURL ?? "");
        emit(AuthSuccessState());
      } else {
        emit(AuthFailureState(errorMessage: 'Sign in failed'));
      }
    } catch (e) {
      emit(AuthFailureState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> _logOutEvent(
      LogOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      authRepository.logout().whenComplete(
        () async {
          // Set the user as logged Out using Hive storage
          await MyHiveBoxes.settingBox.put(MyHiveKeys.userIsLoggedIn, false);
          await MyHiveBoxes.settingBox.put(MyHiveKeys.isAdminLoggedIn, false);
          await MyHiveBoxes.settingBox.delete(MyHiveKeys.userNameHiveKey);
          await MyHiveBoxes.settingBox.delete(MyHiveKeys.userEmailHiveKey);
          await MyHiveBoxes.settingBox.delete(MyHiveKeys.userProfilePicHiveKey);

          Navigator.pushNamedAndRemoveUntil(
            event.context,
            AppRoutes.signInRoute,
            (route) => false,
          );

          emit(AuthSuccessLogOutState());
        },
      );
    } catch (e) {
      emit(AuthFailureState(errorMessage: e.toString()));
    }
  }
}
