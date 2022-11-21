import 'dart:async';

import 'package:apiaccurate/models/user_model.dart';
import 'package:apiaccurate/widget/search_widget.dart';
import 'package:apiaccurate/widget/add_user_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:apiaccurate/logic/cubits/user_state.dart';
import 'package:apiaccurate/logic/cubits/user_cubit.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = StreamController<SwipeRefreshState>.broadcast();

  Stream<SwipeRefreshState> get _stream => _controller.stream;

  bool isDescending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accurate API"),
        actions: [
          IconButton(
            icon: const RotatedBox(
              quarterTurns: 1,
              child: Icon(
                Icons.compare_arrows,
                size: 25,
                color: Colors.white,
              ),
            ),
            // label: Text(
            //   isDescending ? 'Descending' : 'Ascending',
            //   style: const TextStyle(fontSize: 12, color: Colors.white),
            // ),
            onPressed: () => setState(() => isDescending = !isDescending),
          ),
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchUser());
            },
            icon: const Icon(Icons.search_sharp),
          ),
        ],
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
              return Column(
                children: [
                  Expanded(
                    child: buildUserListView(state.users),
                  ),
                ],
              );
            }

            return const Center(
              child: Text("Error."),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: const AddUser(),
    );
  }

  Widget buildUserListView(List<UserModel> users) {
    if (users.isNotEmpty) {
      return SwipeRefresh.builder(
        stateStream: _stream,
        onRefresh: _refresh,
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final sortedUsers = users
            ..sort((user1, user2) => isDescending
                ? user2.name.toString().compareTo(user1.name.toString())
                : user1.name.toString().compareTo(user2.name.toString()));

          UserModel user = sortedUsers[index];

          return Card(
              child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListTile(
              title: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    /* Untuk menampilkan id*/
                    child: Center(
                      child: Text(
                        user.id.toString(),
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        user.city.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ));
        },
      );
    }

    return const Center(child: Text("Data belum tersedia..."));
  }

  @override
  void dispose() {
    _controller.close();

    super.dispose();
  }

  Future<void> _refresh() async {
    await Future<void>.delayed(const Duration(seconds: 3));
    // when all needed is done change state
    _controller.sink.add(SwipeRefreshState.hidden);
  }
}
