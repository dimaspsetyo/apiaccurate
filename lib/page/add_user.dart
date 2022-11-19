import 'package:apiaccurate/repo/user_repo.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  UserRepository repository = UserRepository();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, '/home');
          },
          icon: const Icon(Icons.arrow_back_ios),
          //replace with our own icon data.
        ),
        title: const Text('Tambah Data User'),
      ),
      body: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Masukkan Nama';
              }
              return null;
            },
            controller: _nameController,
            decoration: const InputDecoration(
                hintText: 'Name', border: OutlineInputBorder()),
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Masukkan Alamat';
              }
              return null;
            },
            controller: _addressController,
            decoration: const InputDecoration(
                hintText: 'Address', border: OutlineInputBorder()),
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Masukkan Email';
              }
              return null;
            },
            controller: _emailController,
            decoration: const InputDecoration(
                hintText: 'Email', border: OutlineInputBorder()),
          ),
          TextFormField(
            controller: _phoneNumberController,
            decoration: const InputDecoration(
                hintText: 'Phone Number', border: OutlineInputBorder()),
          ),
          TextFormField(
            controller: _cityController,
            decoration: const InputDecoration(
                hintText: 'City', border: OutlineInputBorder()),
          ),
          ElevatedButton(
              onPressed: () async {
                bool response = await repository.postUser(
                  _nameController.text,
                  _addressController.text,
                  _emailController.text,
                  _phoneNumberController.text,
                  _cityController.text,
                );

                if (response) {
                  const SnackBar(content: Text('Processing Data'));
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).popAndPushNamed('/home');
                } else {
                  throw ('Data gagal ditambahkan.');
                }
              },
              child: const Text('Tambah Data'))
        ],
      ),
    );
  }
}
