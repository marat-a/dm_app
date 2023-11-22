// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['id'] as int,
      startTime: Order.dateTimeFromJson(json['startTime'] as String?),
      endTime: Order.dateTimeFromJson(json['endTime'] as String?),
      items: json['items'] as String,
      sum: Order.doubleFromJson(json['sum']),
      courier: User.fromJson(json['courier'] as Map<String, dynamic>),
      customer: Customer.fromJson(json['customer'] as Map<String, dynamic>),
      commentForCourier: json['commentForCourier'] as String,
      commentForManager: json['commentForManager'] as String,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'startTime': Order.dateTimeToJson(instance.startTime),
      'endTime': Order.dateTimeToJson(instance.endTime),
      'items': instance.items,
      'sum': Order.doubleToJson(instance.sum),
      'courier': instance.courier,
      'customer': instance.customer,
      'commentForCourier': instance.commentForCourier,
      'commentForManager': instance.commentForManager,
    };
