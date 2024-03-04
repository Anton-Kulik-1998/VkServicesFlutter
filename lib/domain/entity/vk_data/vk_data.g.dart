// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vk_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VKData _$VKDataFromJson(Map<String, dynamic> json) => VKData(
      body: Body.fromJson(json['body'] as Map<String, dynamic>),
      status: json['status'] as int,
    );

Map<String, dynamic> _$VKDataToJson(VKData instance) => <String, dynamic>{
      'body': instance.body,
      'status': instance.status,
    };
