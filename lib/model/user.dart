

import 'package:json_annotation/json_annotation.dart';

import '../enums/role.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  late int id;
  late String name;
  late String phone;
  late Role role;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
