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
      userId: json['userId'] as int,
      userName: json['userName'] as String,
      bookName: json['bookName'] as String,
      typeId: json['typeId'] as int,
      title: json['title'] as String,
      author: json['author'] as String,
      url: json['url'] as String,
      content: json['content'] as String,
      createTime: json['createTime'] == null
          ? null
          : DateTime.parse(json['createTime'] as String),
      updateTime: json['updateTime'] == null
          ? null
          : DateTime.parse(json['updateTime'] as String),
      bookStatus: json['bookStatus'] as int,
      bookId: json['bookId'] as int,
      status: json['status'] as int,
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String));
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'userName': instance.userName,
      'bookName': instance.bookName,
      'typeId': instance.typeId,
      'title': instance.title,
      'author': instance.author,
      'url': instance.url,
      'content': instance.content,
      'createTime': instance.createTime?.toIso8601String(),
      'updateTime': instance.updateTime?.toIso8601String(),
      'bookStatus': instance.bookStatus,
      'bookId': instance.bookId,
      'status': instance.status,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String()
    };
