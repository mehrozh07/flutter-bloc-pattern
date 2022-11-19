import 'package:blocs_patteren/internet_connection_bloc/internet_connection.dart';
import 'package:blocs_patteren/internet_connection_bloc/internet_state.dart';
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
          BlocConsumer<InternetConnection, InternetState>(
            listener: (context, state) {
              if (state is InternetGainedState) {
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
              else if (state is InternetLostState) {
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
              if (state is InternetGainedState) {
                return const Text(
                  'Your Internet is Connected',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                );
              } else if (state is InternetLostState) {
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
