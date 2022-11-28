part of 'sign_in_bloc.dart';

abstract class SignInState {}

class SignInInitialState extends SignInState {}

class SignInValidState extends SignInState {}

class SignInErrorTextState extends SignInState {
  String? errorMessage;
  SignInErrorTextState(this.errorMessage);
}

class SignInLoadingState extends SignInState {}
