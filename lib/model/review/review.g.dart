// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) {
  return Review(
      json['id'] as int,
      json['name'] as String,
      json['content'] as String,
      json['url'] as String,
      json['create_time'] as String);
}

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'content': instance.content,
      'url': instance.url,
      'create_time': instance.create_time
    };
