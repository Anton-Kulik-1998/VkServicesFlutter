class Service {
  final String name;
  final String description;
  final String link;
  final String iconURL;

  Service({
    required this.name,
    required this.description,
    required this.link,
    required this.iconURL,
  });
  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      name: json["name"] as String,
      description: json["description"] as String,
      link: json["link"] as String,
      iconURL: json["icon_url"] as String,
    );
  }
}