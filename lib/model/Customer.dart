import 'package:dm_app/model/Role.dart';
import 'package:json_annotation/json_annotation.dart';

import 'User.dart';
import 'Order.dart';

part 'Customer.g.dart';

@JsonSerializable()
class Customer extends User {
  final String address;
  final List<Order> orders;

  Customer({required this.address, required this.orders, required String name, required String phone})
      : super( name: '', phone: '', role: Role.USER);

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
        address: json['address'],
        orders: List<Order>.from(
            json['orders'].map((orderJson) => Order.fromJson(orderJson))), name: '', phone: '');
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'orders': orders.map((order) => order.toJson()).toList(),
    };
  }
}
