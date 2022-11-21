import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:apiaccurate/page/home.dart';
import 'package:apiaccurate/page/add_user.dart';
import 'package:apiaccurate/logic/cubits/user/user_cubit.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(),
      child: MaterialApp(
        routes: {
          '/home': (context) => const HomePage(),
          '/add_user': (context) => const AddUser(),
        },
        debugShowCheckedModeBanner: false,
        home: const Scaffold(
          body: DoubleBackToCloseApp(
            snackBar: SnackBar(
              content: Text('Tap back again to leave'),
            ),
            child: HomePage(),
          ),
        ),
      ),
    );
  }
}
