import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitialState()) {
    on<SigninEmailChangeEvent>((event, emit) {
       if(EmailValidator.validate(event.emailValue!) == false){
        emit(SignInErrorTextState("enter valid email"));
      }else{
        emit(SignInValidState());
      }
    });
on<SigninPasswordChangeEvent>((event, emit){
  if(event.passwordValue!.length < 6){
    emit(SignInErrorTextState('enter valid password'));
  }else{
    emit(SignInValidState());
  }
});
    on<SigninButtonEvent>((event, emit){
      emit(SignInLoadingState());
    });

  }
}
