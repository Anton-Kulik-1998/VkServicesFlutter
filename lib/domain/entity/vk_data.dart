import 'package:vk_services_flutter/domain/entity/entity.dart';

class VKData {
  final Body body;
  final int status;

  VKData({
    required this.body,
    required this.status,
  });
  factory VKData.fromJson(Map<String, dynamic> json) {
    return VKData(
      body: Body.fromJson(json["body"]),
      status: json["status"] as int,
    );
  }
}
