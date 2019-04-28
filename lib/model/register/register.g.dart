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
      json['company_id'] as String,
      json['nameError'] as bool,
      json['phoneError'] as bool,
      json['emailError'] as bool,
      json['positionError'] as bool,
      json['companyError'] as bool
  );

}

Map<String, dynamic> _$RegisterToJson(Register instance) => <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'position': instance.position,
      'company_id': instance.company_id,

      'nameError': instance.nameError,
      'phoneError': instance.phoneError,
      'emailError': instance.emailError,
      'positionError': instance.positionError,
      'companyError': instance.companyError
    };
