import 'dart:collection';
import 'dart:convert';

import 'package:dm_app/repository/roles_repository.dart';
import 'package:flutter/material.dart';

import '../enums/erole.dart';
import '../enums/role.dart';
import '../model/user.dart';
import '../repository/http_client.dart';

class UserCreateScreen extends StatefulWidget {
  @override
  UserCreateScreenState createState() => UserCreateScreenState();
}

class UserCreateScreenState extends State<UserCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _loginController = TextEditingController();
  late BuildContext _scaffoldContext;
  Set<Role> selectedRoles = {};
  List<Role> roles = []; // List to store the roles fetched from the API

  @override
  void initState() {
    super.initState();

    // Fetch roles from the API
    fetchRoles();
  }

  Future<void> fetchRoles() async {
    try {
      final response = await HttpClient.get('/roles'); // Replace with the actual API endpoint to fetch roles
      if (response.statusCode == 200) {
        final List<dynamic> rolesData = jsonDecode(response.body);
        setState(() {
          roles = rolesData.map((role) => Role.fromJson(role)).toList();
        });
      } else {
        setState(() {
          roles = selectedRoles.toList();
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _loginController.dispose();
    super.dispose();
  }

  Future<void> _saveUser() async {
    if (_formKey.currentState!.validate()) {
      final newUser = User(
        name: _nameController.text,
        phone: _phoneController.text,
        password: _passwordController.text,
        login: _loginController.text,
        roles: selectedRoles,
      );

      try {
        final response = await HttpClient.post('/users', body: newUser);
        if (response.statusCode == 201) {
          _showSnackBar('User created successfully');
          Navigator.pop(_scaffoldContext, true);
        } else {
          throw Exception('Failed to create user');
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(_scaffoldContext).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _buildRoleCheckbox(Role role) {
    List<Role> rolesList = selectedRoles.toList();
    final isChecked = rolesList.contains(role);

    return CheckboxListTile(
      title: Text(role.name.name.split('.').last),
      value: isChecked,
      onChanged: (value) {
        setState(() {
          if (value != null && value) {
            selectedRoles.add(role);
          } else {
            selectedRoles.remove(role);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create User'),
      ),
      body: Builder(
        builder: (BuildContext context) {
          _scaffoldContext = context; // Store the BuildContext
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(labelText: 'Phone'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _loginController,
                    decoration: const InputDecoration(labelText: 'Login'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a login';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Roles',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: roles.map((role) => _buildRoleCheckbox(role)).toList(),
                  ),
                  ElevatedButton(
                    onPressed: _saveUser,
                    child: const Text('Create'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}