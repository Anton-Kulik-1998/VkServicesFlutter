import 'package:vk_services_flutter/repositories/vk_services/models/models.dart';

class Body {
  final List<Service> services;

  Body({required this.services});
  factory Body.fromJson(Map<String, dynamic> json) {
    List<Service> services = [];
    for (var serviceJson in json['services']) {
      services.add(Service.fromJson(serviceJson));
    }
    return Body(services: services);
  }
}