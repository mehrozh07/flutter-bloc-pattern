part of 'auth_cubit.dart';


abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState{}

class LoggedInState extends AuthState{
  User? user;
  LoggedInState(this.user);
}

class AuthCodeSentState extends AuthState{}

class AuthCodeVerifyState extends AuthState{}

class AuthLogOutState extends AuthState{}

class AuthErrorState extends AuthState{
  String? error;
  AuthErrorState(this.error);
}
