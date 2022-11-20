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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, '/home');
          },
          icon: const Icon(Icons.arrow_back_ios),
          //replace with our own icon data.
        ),
        title: const Text('Add User Data'),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 50.0, vertical: 16.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name cannot be empty';
                    }
                    return null;
                  },
                  controller: _nameController,
                  maxLength: 30,
                  decoration: const InputDecoration(
                      counterText: '',
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.blueAccent,
                      ),
                      labelText: 'Input User Name',
                      border: UnderlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 50.0, vertical: 16.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Address cannot be empty';
                    }
                    return null;
                  },
                  controller: _addressController,
                  maxLength: 70,
                  decoration: const InputDecoration(
                      counterText: '',
                      prefixIcon: Icon(
                        Icons.home_filled,
                        color: Colors.blueAccent,
                      ),
                      labelText: 'Input User Address',
                      border: UnderlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 50.0, vertical: 16.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email cannot be empty';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  maxLength: 30,
                  decoration: const InputDecoration(
                      counterText: '',
                      prefixIcon: Icon(
                        Icons.email_rounded,
                        color: Colors.blueAccent,
                      ),
                      labelText: 'Input User Email',
                      border: UnderlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 50.0, vertical: 16.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone number cannot be empty';
                    }
                    return null;
                  },
                  controller: _phoneNumberController,
                  maxLength: 12,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      counterText: '',
                      prefixIcon: Icon(
                        Icons.phone_android,
                        color: Colors.blueAccent,
                      ),
                      labelText: 'Input User Phone number',
                      border: UnderlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 50.0, vertical: 16.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'City cannot be empty';
                    }
                    return null;
                  },
                  controller: _phoneNumberController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.location_city,
                        color: Colors.blueAccent,
                      ),
                      labelText: 'Input User City',
                      border: UnderlineInputBorder()),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );

                        bool response = await repository.postUser(
                          _nameController.text,
                          _addressController.text,
                          _emailController.text,
                          _phoneNumberController.text,
                          _cityController.text,
                        );

                        if (response) {
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).popAndPushNamed('/home');
                        } else {
                          throw ('Input Data Failed.');
                        }
                      }
                    },
                    child: const Text('Submit Data',
                        style: TextStyle(fontSize: 15))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
