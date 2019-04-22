// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Register _$RegisterFromJson(Map<String, dynamic> json) {
  return Register(
      json['id'] as int,
      json['book_name'] as String,
      json['user_name'] as String,
      json['status'] as int,
      json['start_time'] == null
          ? null
          : DateTime.parse(json['start_time'] as String),
      json['create_time'] == null
          ? null
          : DateTime.parse(json['create_time'] as String),
      json['update_time'] == null
          ? null
          : DateTime.parse(json['update_time'] as String));
}

Map<String, dynamic> _$RegisterToJson(Register instance) => <String, dynamic>{
      'id': instance.id,
      'book_name': instance.bookName,
      'user_name': instance.userName,
      'status': instance.status,
      'start_time': instance.startTime?.toIso8601String(),
      'create_time': instance.createTime?.toIso8601String(),
      'update_time': instance.updateTime?.toIso8601String()
    };
