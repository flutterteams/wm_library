import 'package:json_annotation/json_annotation.dart';

/// 将在我们运行生成命令后自动生成
part 'register.g.dart';

/// 这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class Register {
  Register(
      this.name,
      this.phone,
      this.email,
      this.position,
      this.company_id,

      this.nameError,
      this.phoneError,
      this.emailError,
      this.positionError,
      this.companyError
      );


  String name;
  String phone;
  String email;
  String position;
  String company_id;

  bool nameError;
  bool phoneError;
  bool emailError;
  bool positionError;
  bool companyError;


  @override
  String toString() {
    return 'Register{name: $name, phone: $phone, email: $email, position: $position, company_id: $company_id, nameError: $nameError, phoneError: $phoneError, emailError: $emailError, positionError: $positionError, companyError: $companyError}';
  }

  /// 命名构造函数
  Register.empty();

  /// 不同的类使用不同的mixin即可
  factory Register.fromJson(Map<String, dynamic> json) =>
      _$RegisterFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterToJson(this);
}
