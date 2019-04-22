import 'package:json_annotation/json_annotation.dart';

/// 将在我们运行生成命令后自动生成
part 'register.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class Register {
  Register(this.id, this.bookName, this.userName, this.status,
      this.startTime, this.createTime, this.updateTime);

  int id;
  @JsonKey(name: 'book_name')
  String bookName;
  @JsonKey(name: 'user_name')
  String userName;
  int status;
  @JsonKey(name: 'start_time')
  DateTime startTime;
  @JsonKey(name: 'create_time')
  DateTime createTime;
  @JsonKey(name: 'update_time')
  DateTime updateTime;

  /// 命名构造函数
  Register.empty();

  /// 不同的类使用不同的mixin即可
  factory Register.fromJson(Map<String, dynamic> json) =>
      _$RegisterFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterToJson(this);
}
