import 'package:json_annotation/json_annotation.dart';

import '../enums/role.dart';
import 'order.dart';
import 'user.dart';

part 'customer.g.dart';

@JsonSerializable()
class Customer extends User {
  String? address;
  List<Order>? orders;

  Customer({
    super.id,
    super.name,
    super.phone,
    super.password,
    super.roles,
    super.login,
    this.address,
    this.orders,
  });

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}