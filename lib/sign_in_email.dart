import 'package:blocs_patteren/sign_in_blocs/sign_in_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInEmail extends StatelessWidget {
  SignInEmail({Key? key}) : super(key: key);
  bool isPassword = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child:
        ListView(physics: const AlwaysScrollableScrollPhysics(), children: [
          const Text(
            'Email',
          ),
          BlocBuilder<SignInBloc, SignInState>(
            builder: (context, state) {
              return TextFormField(
                controller: emailController,
                  onChanged: (value) {
                    BlocProvider.of<SignInBloc>(context).add(
                        SigninEmailChangeEvent(
                            emailController.text));
                  },
                  decoration: InputDecoration(
                      errorText: state is SignInErrorTextState ? "${state
                          .errorMessage}" : "",
                      border: InputBorder.none,
                      fillColor: const Color(0xfff3f3f4),
                      filled: true));
            },
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'password',
          ),
          BlocBuilder<SignInBloc, SignInState>(
            builder: (context, state) {
              return TextFormField(
                controller: passwordController,
                  onChanged: (value) {
                    BlocProvider.of<SignInBloc>(context).add(
                        SigninEmailChangeEvent(
                            passwordController.text));
                  },
                  decoration: InputDecoration(
                      errorText: state is SignInErrorTextState ? "${state
                          .errorMessage}" : "",
                      border: InputBorder.none,
                      fillColor: const Color(0xfff3f3f4),
                      filled: true));
            },
          ),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<SignInBloc, SignInState>(
            builder: (context, state) {
              return CupertinoButton(
                color: (state is SignInValidState)
                    ? Colors.blueAccent
                    : Colors.grey.shade300,
                child: Text(
                  'Sign in',
                  style: TextStyle(
                      color: (state is SignInValidState)
                          ? Colors.white
                          : Colors.black54),
                ),
                onPressed: () {

                },
              );
            },
          ),
        ]),
      ),
    );
  }
}
