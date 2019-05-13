import 'package:json_annotation/json_annotation.dart';

/// login.g.dart 将在我们运行生成命令后自动生成
part 'book.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class Book {
  Book(this.id, this.title, this.author,this.url, this.type_id, this.create_time,
      this.background, this.foreground, this.content);

  @JsonKey(name: 'bookId')
  int id;

  String title;
  String author;
  String url;
  int type_id;
  DateTime create_time;
  String foreground;
  String background;

  String content;

  // 命名构造函数
  Book.empty();

  @override
  String toString() {
    return 'Book{id: $id, title: $title, author: $author, type_id: $type_id, create_time: $create_time, content: $content}';
  }

  /// 不同的类使用不同的mixin即可
  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  Map<String, dynamic> toJson() => _$BookToJson(this);
}
