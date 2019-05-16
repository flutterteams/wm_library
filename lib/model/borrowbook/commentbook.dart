import 'package:json_annotation/json_annotation.dart';

part 'commentbook.g.dart';

@JsonSerializable()
class CommentBook {
  CommentBook( this.content, this.commentError);


  String content;
  bool commentError;

  /// 命名构造函数
  CommentBook.empty();


  /// 不同的类使用不同的mixin即可
  factory CommentBook.fromJson(Map<String, dynamic> json) => _$CommentBookFromJson(json);

  Map<String, dynamic> toJson() => _$CommentBookToJson(this);
}
