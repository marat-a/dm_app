import 'package:flutter/material.dart';
import '../enums/role.dart';
import '../model/user.dart';
import './user_edit_form.dart';

class UserDetailsScreen extends StatelessWidget {
  final User user;

  const UserDetailsScreen({Key? key, required this.user}) : super(key: key);

  String _getRolesString(Set<Role>? roles) {
    if (roles == null || roles.isEmpty) {
      return '';
    }
    return roles.map((role) => role.name.toString().split('.').last).join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserEditScreen(user: user),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            title: const Text('Name'),
            subtitle: Text(user.name ?? ''),
          ),
          ListTile(
            title: const Text('Phone'),
            subtitle: Text(user.phone ?? ''),
          ),
          ListTile(
            title: const Text('Password'),
            subtitle: Text(user.password ?? ''),
          ),
          ListTile(
            title: const Text('Roles'),
            subtitle: Text(_getRolesString(user.roles) ?? ''),
          ),
          ListTile(
            title: const Text('Login'),
            subtitle: Text(user.login ?? ''),
          ),
        ],
      ),
    );
  }
}