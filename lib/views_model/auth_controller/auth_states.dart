part of 'auth_cubit.dart';

abstract class AuthStates {}

class InitialAuthState extends AuthStates {}

class SignInWithGoogleState extends AuthStates {
  final ApiRequestStatus status;
  SignInWithGoogleState(this.status);
}

class SignInWithFacebookState extends AuthStates {
  final ApiRequestStatus status;
  SignInWithFacebookState(this.status);
}