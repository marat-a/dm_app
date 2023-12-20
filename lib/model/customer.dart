import 'package:json_annotation/json_annotation.dart';

import '../enums/role.dart';
import 'user.dart';
import 'order.dart';

part 'customer.g.dart';

@JsonSerializable()
class Customer extends User {
  late String address;
  late List<Order> orders;

  Customer({
    required super.id,
    required super.name,
    required super.phone,
    required super.role,
    required this.address,
    required this.orders,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}