import 'package:dm_app/model/product.dart';
import 'package:json_annotation/json_annotation.dart';

import '../enums/pay_status.dart';
import '../enums/progress_status.dart';
import 'customer.dart';
import 'delivery_info.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  int? id;
  DeliveryInfo? deliveryInfo;
  List<Product>? products;
  double? sum;
   double? paid;
   PayStatus? payStatus;
   ProgressStatus? progressStatus;
   Customer? customer;
   String? commentForManager;

  Order({
    required this.id,
    required this.deliveryInfo,
    required this.products,
    required this.sum,
    required this.paid,
    required this.payStatus,
    required this.progressStatus,
    required this.customer,
    required this.commentForManager,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}