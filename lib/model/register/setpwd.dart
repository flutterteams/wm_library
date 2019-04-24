import 'package:json_annotation/json_annotation.dart';

part 'setpwd.g.dart';

@JsonSerializable()
class SetPwd {
   String password;
   String confirmPassword;

   SetPwd({this.password,this.confirmPassword});

  factory SetPwd.fromJson(Map<String, dynamic> json) => _$SetPwdFromJson(json);
  Map<String, dynamic> toJson() => _$SetPwdToJson(this);
}