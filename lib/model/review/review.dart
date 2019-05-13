import 'package:json_annotation/json_annotation.dart';

/// login.g.dart 将在我们运行生成命令后自动生成
part 'review.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class Review {
  Review(this.id, this.name,this.content, this.url, this.create_time);

  int id;
  String name;
  String content;
  String url;
  String create_time;



  // 命名构造函数
  Review.empty();

  /// 不同的类使用不同的mixin即可
  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
