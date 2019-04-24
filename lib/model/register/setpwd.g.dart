// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setpwd.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetPwd _$SetPwdFromJson(Map<String, dynamic> json) {
  return SetPwd(
      password: json['password'] as String,
      confirmPassword: json['confirmPassword'] as String);
}

Map<String, dynamic> _$SetPwdToJson(SetPwd instance) => <String, dynamic>{
      'password': instance.password,
      'confirmPassword': instance.confirmPassword
    };
