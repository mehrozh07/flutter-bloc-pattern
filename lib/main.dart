import 'package:blocs_patteren/Repo/product_repo.dart';
import 'package:blocs_patteren/api_practice/logic/post_cubit.dart';
import 'package:blocs_patteren/authentication/auth_cubit.dart';
import 'package:blocs_patteren/cubits/internet_cubit.dart';
import 'package:blocs_patteren/main-screens/Firebase-Data-View/firebase_data.dart';
import 'package:blocs_patteren/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Firebase-Blocs/Add-Data-Blocs/app_bloc.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => AuthCubit()),
    BlocProvider(create: (_) => InternetCubit()),
    BlocProvider(create: (_) => PostCubit()),
  ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.black,
        ),
        darkTheme: ThemeData.dark(),
        home: RepositoryProvider(
            create: (BuildContext context)=> ProductRepository(),
        child: const MyHomePage())
      // BlocBuilder<AuthCubit, AuthState>(
      //   buildWhen: (oldState, newState) {
      //     return oldState is AuthInitial;
      //   },
      //   builder: (context, state) {
      //     if (state is LoggedInState) {
      //       return const HomeScreen();
      //     } else if (state is AuthLogOutState) {
      //       return const HomePage();
      //     }
      //     return const Scaffold();
      //   },
      // ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});


  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return BlocProvider(
      create: (context) => ProductBloc(
          productRepository: RepositoryProvider.of<ProductRepository>(context)
      ),
      child: Scaffold(
        key: scaffoldKey,
        body: BlocListener<ProductBloc, ProductState>(
          listener: (context, state){
            if(state is ProductAdded){
              Utils.message("product added", context);
            }
          },
          child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state){
                if(state is ProductAdding){
                  return const Center(child: CircularProgressIndicator());
                }
                if(state is ProductError){
                  return const Center(child: Text("error"));
                }
                return const AddData();
              },
          ),
        ),
      ),
    );
  }
}
