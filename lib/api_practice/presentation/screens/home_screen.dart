import 'package:blocs_patteren/api_practice/logic/post_cubit.dart';
import 'package:blocs_patteren/api_practice/logic/post_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("API Handling",
          style: TextStyle(color: Colors.white),),
      ),
      body: SafeArea(
        child: BlocConsumer<PostCubit, PostState>(
          listener: (context, state){
            if(state is ErrorState){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error.toString(),),
                backgroundColor: Colors.pinkAccent,
              ));
            }
          },
          builder: (context, state) {
            if(state is PostLoadingState){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if(state is PostLoadedState){
              return ListView.builder(
                itemCount: state.posts.length,
                  shrinkWrap: true,
                  itemBuilder: (context, snapshot){
                return ListTile(
                  title: Text('${state.posts[snapshot].title}'),
                  subtitle: Text(state.posts[snapshot].body.toString()),
                  leading: Text(state.posts[snapshot].id.toString()),
                );
              });
            }
            if(state is ErrorState){
              return Text(state.error.toString());
            }
            return const Text('data');
          },
        ),
      ),
    );
  }
}
