// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Login _$LoginFromJson(Map<String, dynamic> json) {
  return Login(
      json['email'] as String,
      json['pw'] as String,
      json['emailError'] as bool,
      json['pwError'] as bool,
      json['emailErrorStr'] as String,
      json['pwErrorStr'] as String);
}

Map<String, dynamic> _$LoginToJson(Login instance) => <String, dynamic>{
      'email': instance.email,
      'pw': instance.pw,
      'emailError': instance.emailError,
      'pwError': instance.pwError,
      'emailErrorStr': instance.emailErrorStr,
      'pwErrorStr': instance.pwErrorStr
    };
