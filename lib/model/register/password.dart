import 'package:json_annotation/json_annotation.dart';

part 'password.g.dart';

@JsonSerializable()
class PassWord {
   String password;
   String confirmPassword;
   bool pwdError;
   bool confirmPwdError;
   bool isSuccess;

   PassWord.empty();
   PassWord(this.password,this.confirmPassword,this.pwdError,this.confirmPwdError,this.isSuccess);

  factory PassWord.fromJson(Map<String, dynamic> json) => _$PassWordFromJson(json);
  Map<String, dynamic> toJson() => _$PassWordToJson(this);
}