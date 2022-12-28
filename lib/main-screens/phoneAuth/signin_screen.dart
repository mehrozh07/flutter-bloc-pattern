import 'package:blocs_patteren/authentication/auth_cubit.dart';
import 'package:blocs_patteren/main-screens/phoneAuth/verify_otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({Key? key}) : super(key: key);
  var phoneController = TextEditingController();

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
            controller: phoneController,
            keyboardType: TextInputType.phone,
            maxLength: 13,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              fillColor: Colors.grey.shade100,
              focusColor: Colors.grey.shade100,
              labelText: 'Phone Number',
              filled: true,
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Your phone Number';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if(state is AuthCodeSentState){
                Navigator.push(context, CupertinoPageRoute(builder: (context)=> VerifyOtp()));
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
                );
              }
              return CupertinoButton(
                  color: Theme.of(context).primaryColor,
                  disabledColor: Theme.of(context).primaryColor,
                  child: const Text('Login'),
                  onPressed: () {
                    BlocProvider.of<AuthCubit>(context).sendOtp(phoneController.text);
                  });
            },
          )
        ],
      ),
    );
  }
}
