part of 'sign_in_bloc.dart';


abstract class SignInEvent {}

class SigninEmailChangeEvent extends SignInEvent{
  String? emailValue;

  SigninEmailChangeEvent(this.emailValue,);
}

class SigninPasswordChangeEvent extends SignInEvent{
  String? passwordValue;

  SigninPasswordChangeEvent(this.passwordValue);
}


class SigninButtonEvent extends SignInEvent {
  String? emailBtn;
  String? passwordBtn;

  SigninButtonEvent(this.emailBtn, this.passwordBtn);
}
