import 'package:vk_services_flutter/domain/entity/entity.dart';

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