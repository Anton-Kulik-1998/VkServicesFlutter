import 'package:json_annotation/json_annotation.dart';
import 'package:vk_services_flutter/domain/entity/entity.dart';

part 'body.g.dart';

@JsonSerializable()
class Body {
  final List<Service> services;

  Body({required this.services});
  factory Body.fromJson(Map<String, dynamic> json) => _$BodyFromJson(json);
  Map<String, dynamic> toJson() => _$BodyToJson(this);
}
