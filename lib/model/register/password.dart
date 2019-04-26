import 'package:json_annotation/json_annotation.dart';

part 'password.g.dart';

@JsonSerializable()
class PassWord {
   String password;
   String confirmPassword;

   PassWord.empty();

   PassWord(this.password,this.confirmPassword);

  factory PassWord.fromJson(Map<String, dynamic> json) => _$PassWordFromJson(json);
  Map<String, dynamic> toJson() => _$PassWordToJson(this);
}