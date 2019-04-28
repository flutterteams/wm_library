// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PassWord _$PassWordFromJson(Map<String, dynamic> json) {
  return PassWord(json['password'] as String, json['confirmPassword'] as String,
      json['pwdError'] as bool, json['confirmPwdError'] as bool);
}


Map<String, dynamic> _$PassWordToJson(PassWord instance) => <String, dynamic>{
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
      'pwdError': instance.pwdError,
      'confirmPwdError': instance.confirmPwdError
    };
