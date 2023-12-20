// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      id: json['id'] as int,
      name: json['name'] as String,
      phone: json['phone'] as String,
      role: $enumDecode(_$RoleEnumMap, json['role']),
      address: json['address'] as String,
      orders: (json['orders'] as List<dynamic>)
          .map((e) => Order.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'role': _$RoleEnumMap[instance.role]!,
      'address': instance.address,
      'orders': instance.orders,
    };

const _$RoleEnumMap = {
  Role.ADMIN: 'ADMIN',
  Role.USER: 'USER',
};
