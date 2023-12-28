import 'dart:convert';

import 'package:dm_app/repository/roles_repository.dart';
import 'package:flutter/material.dart';

import '../enums/erole.dart';
import '../enums/role.dart';
import '../model/user.dart';
import '../repository/http_client.dart';

class UserEditScreen extends StatefulWidget {
  final User user;

  const UserEditScreen({super.key, required this.user});

  @override
  UserEditScreenState createState() => UserEditScreenState();
}

class UserEditScreenState extends State<UserEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final List<Role> _selectedRoles = [];
  late BuildContext _scaffoldContext;
  List<Role> _allRoles = [];

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user.name ?? '';
    _phoneController.text = widget.user.phone ?? '';
    _passwordController.text = widget.user.password ?? '';
    _fetchRoles();
    _selectedRoles.addAll(widget.user.roles!.toSet()); // Initialize selected roles
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  Future<void> _fetchRoles() async {
    final response = await HttpClient.get('/roles');
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      setState(() {
        _allRoles = responseData.map((json) => Role.fromJson(json)).toList();
      });
    }
  }
  Future<void> _saveUser() async {
    if (_formKey.currentState!.validate()) {
      final updatedUser = User(
        id: widget.user.id,
        name: _nameController.text,
        phone: _phoneController.text,
        password: _passwordController.text,
        roles: _selectedRoles.toSet(), // Use the selected roles
        login: widget.user.login,
      );

      try {
        final response = await HttpClient.put('/users/${widget.user.id}', body: updatedUser);
        if (response.statusCode == 200) {
          // User updated successfully
          _showSnackBar('User updated successfully');
          Navigator.pop(_scaffoldContext); // Return to previous screen using the stored BuildContext
        } else {
          throw Exception('Failed to update user');
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  void _toggleRole(Role role) {
    setState(() {
      if (_selectedRoles.contains(role)) {
        _selectedRoles.remove(role);
      } else {
        _selectedRoles.add(role);
      }
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(_scaffoldContext).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User'),
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
                  const SizedBox(height: 16),
                  const Text(
                    'Roles',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: _allRoles.length,
                    itemBuilder: (context, index) {
                      final eRole = ERole.values[index];
                      final isChecked = _selectedRoles.toList().toString().contains(eRole.name);

                      return CheckboxListTile(
                        title: Text(eRole.name),
                        value: isChecked,
                        onChanged: (value) => _toggleRole(_allRoles.firstWhere((role) => role.name == eRole)),
                      );
                    },
                  ),
                  ElevatedButton(
                    onPressed: _saveUser,
                    child: const Text('Save'),
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