import 'package:json_annotation/json_annotation.dart';

/// login.g.dart 将在我们运行生成命令后自动生成
part 'comment.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class Comment {
  Comment(this.id, this.review_id, this.user_id, this.name, this.content,
      this.url, this.create_time);

  int id;
  int review_id;
  int user_id;
  String name;
  String content;
  String url;
  String create_time;

  // 命名构造函数
  Comment.empty();

  /// 不同的类使用不同的mixin即可
  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
