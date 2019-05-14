// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) {
  return Order(
      json['id'] as int,
      json['status'] as int,
      json['user_id'] as int,
      json['name'] as String,
      json['borrow_year'] as int,
      json['borrow_month'] as int);
}

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'status': instance.status,
      'name': instance.name,
      'borrow_year': instance.borrow_year,
      'borrow_month': instance.borrow_month
    };
