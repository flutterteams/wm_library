import 'package:json_annotation/json_annotation.dart';

part 'userinfo.g.dart';

@JsonSerializable()
class UserInfo {
  int code;
  String msg;
  Data data;

  UserInfo({this.code, this.msg, this.data});


  UserInfo.empty();

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}

@JsonSerializable()
class Data {
  String name;
  String email;
  String phone;
  String url;
  String signature;
  int company_id;
  int status;
  String createTime;
  String updateTime;
  String position;
  int regStatus;

  bool signError;
  bool positionError;
  bool companyError;


  Data(
      {this.name,
        this.email,
        this.phone,
        this.url,
        this.signature,
        this.company_id,
        this.status,
        this.createTime,
        this.updateTime,
        this.position,
        this.regStatus,
        this.signError,
        this.positionError,
        this.companyError,
      }
      );


  factory Data.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}

