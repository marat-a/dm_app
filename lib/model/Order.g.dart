// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['id'] as int,
      deliveryInfo:
          DeliveryInfo.fromJson(json['deliveryInfo'] as Map<String, dynamic>),
      products: (json['products'] as List<dynamic>)
          .map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList(),
      sum: (json['sum'] as num).toDouble(),
      paid: (json['paid'] as num).toDouble(),
      payStatus: $enumDecode(_$PayStatusEnumMap, json['payStatus']),
      progressStatus:
          $enumDecode(_$ProgressStatusEnumMap, json['progressStatus']),
      customer: Customer.fromJson(json['customer'] as Map<String, dynamic>),
      commentForManager: json['commentForManager'] as String,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'deliveryInfo': instance.deliveryInfo,
      'products': instance.products,
      'sum': instance.sum,
      'paid': instance.paid,
      'payStatus': _$PayStatusEnumMap[instance.payStatus]!,
      'progressStatus': _$ProgressStatusEnumMap[instance.progressStatus]!,
      'customer': instance.customer,
      'commentForManager': instance.commentForManager,
    };

const _$PayStatusEnumMap = {
  PayStatus.UNPAID: 'UNPAID',
  PayStatus.PAID: 'PAID',
  PayStatus.PARTPAID: 'PARTPAID',
};

const _$ProgressStatusEnumMap = {
  ProgressStatus.NOTAPPROVED: 'NOTAPPROVED',
  ProgressStatus.APPROVED: 'APPROVED',
  ProgressStatus.INPROGRESS: 'INPROGRESS',
  ProgressStatus.COMPLETED: 'COMPLETED',
};
