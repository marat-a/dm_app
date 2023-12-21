import 'package:json_annotation/json_annotation.dart';

import '../enums/role.dart';
import 'user.dart';
import 'order.dart';

part 'customer.g.dart';

@JsonSerializable()
class Customer extends User {
   String? address;
   List<Order>? orders;



  factory Customer.fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}