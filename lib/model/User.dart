

import 'package:json_annotation/json_annotation.dart';

import 'Role.dart';

part 'User.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'phone')
  final String phone;
  @JsonKey(name: 'role')
  final Role role;

  User({required this.name, required this.phone, required this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      phone: json['phone'],
      role: Role.values[json['role']],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'role': role.index,
    };
  }
}