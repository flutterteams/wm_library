// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointmentbook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentBook _$AppointmentBookFromJson(Map<String, dynamic> json) {
  return AppointmentBook(
      code: json['code'] as int,
      msg: json['msg'] as String,
      data: (json['data'] as List)
          ?.map((e) =>
              e == null ? null : Data.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$AppointmentBookToJson(AppointmentBook instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      userName: json['user_name'] as String,
      bookName: json['book_name'] as String,
      typeId: json['type_id'] as int,
      title: json['title'] as String,
      author: json['author'] as String,
      url: json['url'] as String,
      content: json['content'] as String,
      createTime: json['create_time'] == null
          ? null
          : DateTime.parse(json['create_time'] as String),
      updateTime: json['update_time'] == null
          ? null
          : DateTime.parse(json['update_time'] as String),
      bookStatus: json['bookStatus'] as int,
      bookId: json['book_id'] as int,
      status: json['status'] as int,
      startTime: json['start_time'] == null
          ? null
          : DateTime.parse(json['start_time'] as String),
      endTime: json['end_time'] == null
          ? null
          : DateTime.parse(json['end_time'] as String));
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'user_name': instance.userName,
  'book_name': instance.bookName,
  'type_id': instance.typeId,
  'title': instance.title,
  'author': instance.author,
  'url': instance.url,
  'content': instance.content,
  'create_time': instance.createTime?.toIso8601String(),
  'update_time': instance.updateTime?.toIso8601String(),
  'bookStatus': instance.bookStatus,
  'book_id': instance.bookId,
  'status': instance.status,
  'start_time': instance.startTime?.toIso8601String(),
  'end_time': instance.endTime?.toIso8601String()
    };
