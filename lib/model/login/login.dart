import 'package:json_annotation/json_annotation.dart';

/// login.g.dart 将在我们运行生成命令后自动生成
part 'login.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class Login {
  Login(this.email, this.pw);

  String email;
  String pw;

  /// 命名构造函数
  Login.empty();

  @override
  String toString() {
    return 'Login($email, $pw)';
  }

  /// 不同的类使用不同的mixin即可
  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);

  Map<String, dynamic> toJson() => _$LoginToJson(this);
}
