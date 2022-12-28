import 'package:blocs_patteren/authentication/auth_cubit.dart';
import 'package:blocs_patteren/cubits/internet_cubit.dart';
import 'package:blocs_patteren/main-screens/phoneAuth/signin_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connectivity Plus"),
        centerTitle: true,
        actions: [
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if(state is AuthLogOutState){
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context)=> SigninScreen()));
              }
            },
            builder: (context, state) {
              return IconButton(
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext dialogContext) {
                        return CupertinoAlertDialog(
                          title: const Text('Sign Out'),
                          content: const Text('Are Your Sure?'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Sign Out'),
                              onPressed: () {
                                BlocProvider.of<AuthCubit>(context).logout();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.logout));
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //TODO: Use of BlocBuilder?
          //TODO: This is just example of Internet Connection checking using Bloc Pattern.
          // TODO: Here I used to BlocBuilder for check Internet Connection.
          // TODO:'BlocBuilder is used to check state only in UI Form. Its really nice state management.
          //TODO: Use of BlocListner?
          //TODO: BlocListner is used to show state in background not in UI form.
          //TODO: What Shoud be used to show both Ui form state and background sate?
          //TODO: Bloc Concumer is muxture of both to show both UI form on screen and background
          const Text(
              'This is just example of Internet Connection checking using Bloc Pattern.'
                  'Here I used to BlocBuilder for check Internet Connection. '
                  'BlocBuilder is used to check state only in UI Form. Its really nice state management'),
          const SizedBox(
            height: 30,
          ),
          BlocConsumer<InternetCubit, InternetState>(
            listener: (context, state) {
              if (state == InternetState.gainedState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(CupertinoIcons.wifi, color: Colors.green,),
                        SizedBox(width: 8),
                        Text('Internet Connection Restored'),
                      ],
                    ),
                    backgroundColor: Colors.black54,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
              else if (state == InternetState.lostState) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Icon(CupertinoIcons.wifi_slash,
                        color: Colors.red,),
                      SizedBox(width: 8),
                      Text('Internet not Connected'),
                    ],
                  ),
                  backgroundColor: Colors.black54,
                  behavior: SnackBarBehavior.floating,
                ));
              }
            },
            builder: (context, state) {
              if (state == InternetState.gainedState) {
                return const Text(
                  'Your Internet is Connected',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                );
              } else if (state == InternetState.lostState) {
                return const Text(
                  'Your Internet is Not Connected',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                );
              }
              return const Text('Loading');
            },
          ),
        ],
      ),
    );
  }
}
