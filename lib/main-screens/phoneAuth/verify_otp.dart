import 'package:blocs_patteren/authentication/auth_cubit.dart';
import 'package:blocs_patteren/main-screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyOtp extends StatelessWidget {
  VerifyOtp({Key? key}) : super(key: key);
  var otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Auth'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 14, right: 14, top: 8),
        children: [
          TextFormField(
            controller: otpController,
            keyboardType: TextInputType.phone,
            maxLength: 6,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              fillColor: Colors.grey.shade100,
              focusColor: Colors.grey.shade100,
              labelText: 'Enter 6-Digit Otp',
              filled: true,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return '*required';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if(state is LoggedInState){
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context)=> const HomeScreen()));
              }else if(state is AuthErrorState){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('${state.error}'),
                       backgroundColor: Theme.of(context).errorColor,
                  )
                );
              }
            },
            builder: (context, state) {
              if(state is AuthLoadingState){
                showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext dialogContext) {
                    return Center(child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                    ));
                  },
                );              }
              return CupertinoButton(
                  color: Theme.of(context).primaryColor,
                  disabledColor: Theme.of(context).primaryColor,
                  child: Text('Verify Otp'.toUpperCase()),
                  onPressed: () {
                    BlocProvider.of<AuthCubit>(context).verifyOtp(otpController.text);
                  });
            },
          )
        ],
      ),
    );
  }
}
