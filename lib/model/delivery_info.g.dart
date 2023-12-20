// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryInfo _$DeliveryInfoFromJson(Map<String, dynamic> json) => DeliveryInfo(
      id: json['id'] as int,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      courier: User.fromJson(json['courier'] as Map<String, dynamic>),
      deliveryType: $enumDecode(_$DeliveryTypeEnumMap, json['deliveryType']),
      deliveryComment: json['deliveryComment'] as String,
    );

Map<String, dynamic> _$DeliveryInfoToJson(DeliveryInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'courier': instance.courier,
      'deliveryType': _$DeliveryTypeEnumMap[instance.deliveryType]!,
      'deliveryComment': instance.deliveryComment,
    };

const _$DeliveryTypeEnumMap = {
  DeliveryType.PICKUP: 'PICKUP',
  DeliveryType.DELIVERY: 'DELIVERY',
};