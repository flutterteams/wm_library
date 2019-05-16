// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commentbook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentBook _$CommentBookFromJson(Map<String, dynamic> json) {
  return CommentBook(json['content'] as String,
      json['commentError'] as bool
  );
}

Map<String, dynamic> _$CommentBookToJson(CommentBook instance) =>
    <String, dynamic>{
      'content': instance.content,
      'commentError': instance.commentError
    };
