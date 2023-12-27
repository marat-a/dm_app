// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryInfo _$DeliveryInfoFromJson(Map<String, dynamic> json) => DeliveryInfo(
      id: json['id'] as int?,
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      courier: json['courier'] == null
          ? null
          : User.fromJson(json['courier'] as Map<String, dynamic>),
      deliveryComment: json['deliveryComment'] as String?,
    );

Map<String, dynamic> _$DeliveryInfoToJson(DeliveryInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'courier': instance.courier,
      'deliveryComment': instance.deliveryComment,
    };
