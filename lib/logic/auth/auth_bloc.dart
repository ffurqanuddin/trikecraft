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
      // Attempt to sign in the user with the provided email and password
      final userId = await authRepository.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      // If sign-in is successful, emit success state
      if (userId != null) {
        emit(AuthSuccessState());

        // Set the user as logged in using Hive storage
        await MyHiveBoxes.settingBox.put(MyHiveKeys.userIsLoggedIn, true);

        emit(AuthInitialState());
      } else {
        // If sign-in fails, emit failure state with an error message
        emit(AuthFailureState(errorMessage: 'Sign in failed'));
        OneContext().pop();
      }
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase authentication exceptions
      String errorMessage;
      switch (e.code) {
        case 'invalid-credential':
          errorMessage = 'user is not registered';
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'user-disabled':
          errorMessage = 'The user has been disabled.';
          break;
        case 'user-not-found':
          errorMessage = 'No user found for this email.';
          break;
        case 'wrong-password':
          errorMessage = 'The password is incorrect.';
          break;

        default:
          errorMessage = 'An unknown error occurred.';
      }
      emit(AuthFailureState(errorMessage: errorMessage));
    } catch (e) {
      // If there is an exception, emit failure state with the exception message
      emit(AuthFailureState(errorMessage: e.toString()));
      OneContext().pop();
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
        );
        await firestoreRepository.addNewUser(user);
        emit(AuthSuccessState());

        // Set the user as logged in using Hive storage
        await MyHiveBoxes.settingBox.put(MyHiveKeys.userIsLoggedIn, true);

        emit(AuthInitialState());
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
        emit(AuthSuccessState());

        final userData = UserModel(
          fullName: user.displayName ?? "User",
          email: user.email ?? "email",
          profilePicture: user.photoURL ?? "https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg",
          userId: user.uid,
        );

        await firestoreRepository.addNewUser(userData);
        await MyHiveBoxes.settingBox.put(MyHiveKeys.userIsLoggedIn, true);
        emit(AuthInitialState());
      } else {
        emit(AuthFailureState(errorMessage: 'Sign in failed'));
      }
    } catch (e) {
      emit(AuthFailureState(errorMessage: e.toString()));
      OneContext().pop();
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
          Navigator.pushNamedAndRemoveUntil(
            event.context,
            AppRoutes.signInRoute,
            (route) => true,
          );
          emit(AuthSuccessLogOutState());
          emit(AuthInitialState());
        },
      );
    } catch (e) {
      emit(AuthFailureState(errorMessage: e.toString()));
    }
  }
}
