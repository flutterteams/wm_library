// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Register _$RegisterFromJson(Map<String, dynamic> json) {
  return Register(
      json['name'] as String,
      json['phone'] as String,
      json['email'] as String,
      json['position'] as String,
      json['company_id'] as int);
}

Map<String, dynamic> _$RegisterToJson(Register instance) => <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'position': instance.position,
      'company_id': instance.company_id
    };
