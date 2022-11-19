import 'package:apiaccurate/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:apiaccurate/logic/cubits/user_state.dart';
import 'package:apiaccurate/logic/cubits/user_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accurate API"),
      ),
      body: SafeArea(
        child: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserErrorState) {
              SnackBar snackBar = SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is UserLoadedState) {
              return buildUserListView(state.users);
            }

            return const Center(
              child: Text("Error."),
            );
          },
        ),
      ),
    );
  }

  Widget buildUserListView(List<UserModel> users) {
    if (users.isNotEmpty) {
      return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          UserModel user = users[index];

          return Padding(
            padding: const EdgeInsets.all(8),
            child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Text(user.name.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(user.city.toString()),
                  ],
                )),
          );
        },
      );
    }
    return const Center(child: Text("Data belum tersedia..."));
  }
}
