import 'dart:html';

class VKDataModel {
  final Body body;
  final int status;

  VKDataModel({
    required this.body,
    required this.status,
  });
}


class Body {
  final List<Service> services;

  Body({required this.services});
}


class Service {
  final String name;
  final Url link;
  final Url iconURL;

  Service({
    required this.name,
    required this.link,
    required this.iconURL,
  });
}



// // MARK: - Service
// struct Service: Hashable, Codable {
//     let name, serviceDescription: String
//     let link: URL
//     let iconURL: URL