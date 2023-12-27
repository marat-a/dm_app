import 'package:json_annotation/json_annotation.dart';

import '../enums/delivery_type.dart';
import 'user.dart';

part 'delivery_info.g.dart';

@JsonSerializable()
class DeliveryInfo {
  int? id;
  DateTime? startTime;
  DateTime? endTime;
  User? courier;
  // late DeliveryType deliveryType;
  String? deliveryComment;

  DeliveryInfo({
    this.id,
    this.startTime,
    this.endTime,
    this.courier,
    // required this.deliveryType,
    this.deliveryComment,
  });

  factory DeliveryInfo.fromJson(Map<String, dynamic> json) => _$DeliveryInfoFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryInfoToJson(this);
}