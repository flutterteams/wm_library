// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
      json['id'] as int,
      json['review_id'] as int,
      json['user_id'] as int,
      json['name'] as String,
      json['content'] as String,
      json['url'] as String,
      json['create_time'] as String);
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'review_id': instance.review_id,
      'user_id': instance.user_id,
      'name': instance.name,
      'content': instance.content,
      'url': instance.url,
      'create_time': instance.create_time
    };
