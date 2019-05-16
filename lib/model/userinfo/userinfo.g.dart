// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userinfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo(
      code: json['code'] as int,
      msg: json['msg'] as String,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>));
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      url: json['url'] as String,
      signature: json['signature'] as String,
      company_id: json['company_id'] as int,
      status: json['status'] as int,
      createTime: json['createTime'] as String,
      updateTime: json['updateTime'] as String,
      position: json['position'] as String,
      regStatus: json['regStatus'] as int,
      signError: json['signError'] as bool,
      positionError: json['positionError'] as bool,
      companyError: json['companyError'] as bool);
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'url': instance.url,
      'signature': instance.signature,
      'company_id': instance.company_id,
      'status': instance.status,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
      'position': instance.position,
      'regStatus': instance.regStatus,
      'signError': instance.signError,
      'positionError': instance.positionError,
      'companyError': instance.companyError
    };
