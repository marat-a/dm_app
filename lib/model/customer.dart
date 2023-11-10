import 'package:json_annotation/json_annotation.dart';

part 'customer.g.dart';

@JsonSerializable(includeIfNull: false)
class Customer {
  @JsonKey(defaultValue: "")
  final String name;
  @JsonKey(defaultValue: "")
  final String phone;

  const Customer(
      {required this.name, required this.phone});

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}
