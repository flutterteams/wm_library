import 'package:json_annotation/json_annotation.dart';

/// login.g.dart 将在我们运行生成命令后自动生成
part 'index.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class Index {
  Index(this.id, this.list, this.typeList);

  int id;
  List list;
  List typeList;

  /// 命名构造函数
  Index.empty();

  @override
  String toString() {
    return 'Index($id, $list, $typeList)';
  }

  /// 不同的类使用不同的mixin即可
  factory Index.fromJson(Map<String, dynamic> json) => _$IndexFromJson(json);

  Map<String, dynamic> toJson() => _$IndexToJson(this);
}
