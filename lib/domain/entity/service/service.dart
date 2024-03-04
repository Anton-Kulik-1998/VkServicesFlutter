
import 'package:json_annotation/json_annotation.dart';

part 'service.g.dart';

@JsonSerializable()
class Service {
  final String name;
  final String description;
  final String link;
  @JsonKey(name: "icon_url")
  final String iconURL;

  Service({
    required this.name,
    required this.description,
    required this.link,
    required this.iconURL,
  });
  factory Service.fromJson(Map<String, dynamic> json) => _$ServiceFromJson(json);
  Map<String, dynamic> toJson() => _$ServiceToJson(this);
}