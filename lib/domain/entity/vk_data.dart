import 'package:json_annotation/json_annotation.dart';
import 'package:vk_services_flutter/domain/entity/entity.dart';

part 'vk_data.g.dart';

@JsonSerializable()
class VKData {
  final Body body;
  final int status;

  VKData({
    required this.body,
    required this.status,
  });
  factory VKData.fromJson(Map<String, dynamic> json) => _$VKDataFromJson(json);
  Map<String, dynamic> toJson() => _$VKDataToJson(this);
}
