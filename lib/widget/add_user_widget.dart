import 'package:flutter/material.dart';

class AddUser extends StatelessWidget {
  const AddUser({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () => Navigator.pushReplacementNamed(context, '/add_user'),
      foregroundColor: Colors.white,
      backgroundColor: const Color(0xff03dac6),
      autofocus: true,
      elevation: 50,
      highlightElevation: 50,
      label: const Text('ADD'),
      icon: const Icon(Icons.add),
    );
  }
}
