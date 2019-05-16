import 'package:json_annotation/json_annotation.dart';

part 'cancelborrow.g.dart';

@JsonSerializable()
class CancelBorrow {
  CancelBorrow(this.code, this.msg, this.data, this.isCancelborrow);

  int code;
  String msg;
  String data;
  bool isCancelborrow;

  /// 命名构造函数
  CancelBorrow.empty();


  /// 不同的类使用不同的mixin即可
  factory CancelBorrow.fromJson(Map<String, dynamic> json) => _$CancelBorrowFromJson(json);

  Map<String, dynamic> toJson() => _$CancelBorrowToJson(this);
}
