import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  var auth = FirebaseAuth.instance;
  AuthCubit() : super(AuthInitial());

  String? verificationId;

  void sendOtp(String? phoneNumber) async{
    auth.verifyPhoneNumber(
      phoneNumber: '$phoneNumber',
      verificationCompleted: (PhoneAuthCredential credential) {
        signingWithPhoneNumber(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        emit(AuthErrorState(e.message.toString()));
        if (e.code == 'invalid-phone-number') {
          if (kDebugMode) {
            print('The provided phone number is not valid.');
          }
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        emit(AuthCodeSentState());
        this.verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId = verificationId;
      },
    );
  }

  void verifyOtp(String? otp) async{
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
      smsCode: otp!,);
    signingWithPhoneNumber(credential);
  }

  Future<void> signingWithPhoneNumber(PhoneAuthCredential phoneAuthCredential) async {
    try{
      UserCredential userCredential = await auth.signInWithCredential(phoneAuthCredential);
      if(userCredential.user !=null){
        emit(LoggedInState(userCredential.user));
      }
    } on FirebaseAuthException catch(e){
      print(e.message.toString());
    }
  }

}
