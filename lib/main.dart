import 'package:blocs_patteren/api_practice/data/models/repositries/post_repositries.dart';
import 'package:blocs_patteren/api_practice/logic/post_cubit.dart';
import 'package:blocs_patteren/authentication/auth_cubit.dart';
import 'package:blocs_patteren/cubits/internet_cubit.dart';
import 'package:blocs_patteren/main-screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'api_practice/data/models/PostModel.dart';
import 'api_practice/presentation/screens/home_screen.dart';
import 'main-screens/phoneAuth/signin_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  PostRepository postRepository = PostRepository();
  List<PostModel> postModels = await postRepository.fetchApi();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => AuthCubit()),
    BlocProvider(create: (_) => InternetCubit()),
    BlocProvider(create: (_) => PostCubit()),
  ], child: const MyApp()));
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
      home: const HomePage(),
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
