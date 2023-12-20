// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      name: json['name'] as String,
      phone: json['phone'] as String,
      role: $enumDecode(_$RoleEnumMap, json['role']),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'role': _$RoleEnumMap[instance.role]!,
    };

const _$RoleEnumMap = {
  Role.ADMIN: 'ADMIN',
  Role.USER: 'USER',
};
