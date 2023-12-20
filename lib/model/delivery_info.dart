import 'package:json_annotation/json_annotation.dart';

import '../enums/delivery_type.dart';
import 'user.dart';

part 'delivery_info.g.dart';

@JsonSerializable()
class DeliveryInfo {
  late int id;
  late DateTime startTime;
  late DateTime endTime;
  late User courier;
  late DeliveryType deliveryType;
  late String deliveryComment;

  DeliveryInfo({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.courier,
    required this.deliveryType,
    required this.deliveryComment,
  });

  factory DeliveryInfo.fromJson(Map<String, dynamic> json) => _$DeliveryInfoFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryInfoToJson(this);
}