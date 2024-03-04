// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Service _$ServiceFromJson(Map<String, dynamic> json) => Service(
      name: json['name'] as String,
      description: json['description'] as String,
      link: json['link'] as String,
      iconURL: json['icon_url'] as String,
    );

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'link': instance.link,
      'icon_url': instance.iconURL,
    };
