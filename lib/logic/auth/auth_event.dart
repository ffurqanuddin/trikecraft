part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInWithEmailEvent extends AuthEvent {
  const SignInWithEmailEvent({required this.email, required this.password});

  final String email;
  final String password;
  @override
  List<Object> get props => [email, password];
}

class SignUpWithEmailEvent extends AuthEvent {
  final String email;
  final String password;
  final String fullName;
  final String profilePicture;

  const SignUpWithEmailEvent({
    required this.email,
    required this.password,
    required this.fullName,
    required this.profilePicture,
  });

  @override
  List<Object> get props => [email, password, fullName, profilePicture];
}

class AuthWithGoogleEvent extends AuthEvent {}

class ForgotPasswordEvent extends AuthEvent {}

class LogOutEvent extends AuthEvent {

  LogOutEvent();
     @override
   List<Object> get props => [];
}