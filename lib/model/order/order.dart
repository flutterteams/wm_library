import 'package:json_annotation/json_annotation.dart';

/// login.g.dart 将在我们运行生成命令后自动生成
part 'order.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class Order {
  Order(this.id, this.status, this.user_id, this.name, this.borrow_year, this.borrow_month);

  int id;
  int user_id;
  int status;
  String name;
  int borrow_year;
  int borrow_month;

  // 命名构造函数
  Order.empty();

  /// 不同的类使用不同的mixin即可
  factory Order.fromJson(Map<String, dynamic> json) =>
      _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
