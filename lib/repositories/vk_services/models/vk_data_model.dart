import 'package:vk_services_flutter/repositories/vk_services/models/models.dart';

class VKDataModel {
  final Body body;
  final int status;

  VKDataModel({
    required this.body,
    required this.status,
  });
  factory VKDataModel.fromJson(Map<String, dynamic> json) {
    return VKDataModel(
      body: Body.fromJson(json["body"]),
      status: json["status"] as int,
    );
  }
}