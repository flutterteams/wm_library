// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancelborrow.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CancelBorrow _$CancelBorrowFromJson(Map<String, dynamic> json) {
  return CancelBorrow(json['code'] as int, json['msg'] as String,
      json['data'] as String, json['isCancelborrow'] as bool);
}

Map<String, dynamic> _$CancelBorrowToJson(CancelBorrow instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
      'isCancelborrow': instance.isCancelborrow
    };
