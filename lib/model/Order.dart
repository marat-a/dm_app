import 'package:json_annotation/json_annotation.dart';

import 'User.dart';
import 'Customer.dart';

part 'Order.g.dart';

@JsonSerializable()
class Order {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(
    name: 'startTime',
    fromJson: dateTimeFromJson,
    toJson: dateTimeToJson,
  )
  final DateTime startTime;

  @JsonKey(
    name: 'endTime',
    fromJson: dateTimeFromJson,
    toJson: dateTimeToJson,
  )
  final DateTime endTime;

  @JsonKey(name: 'items')
  final String items;

  @JsonKey(
    name: 'sum',
    fromJson: doubleFromJson,
    toJson: doubleToJson,
  )
  final double sum;

  @JsonKey(name: 'courier')
  final User courier;

  @JsonKey(name: 'customer')
  final Customer customer;

  @JsonKey(name: 'commentForCourier')
  final String commentForCourier;

  @JsonKey(name: 'commentForManager')
  final String commentForManager;

  Order({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.items,
    required this.sum,
    required this.courier,
    required this.customer,
    required this.commentForCourier,
    required this.commentForManager,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  static DateTime dateTimeFromJson(String? json) {
    return json != null ? DateTime.parse(json) : DateTime.now();
  }

  static String? dateTimeToJson(DateTime? dateTime) {
    return dateTime?.toIso8601String();
  }

  static double doubleFromJson(dynamic json) {
    return json != null ? json.toDouble() : 0.0;
  }

  static dynamic doubleToJson(double? value) {
    return value?.toDouble();
  }


}
