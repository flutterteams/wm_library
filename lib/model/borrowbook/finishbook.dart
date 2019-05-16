import 'package:json_annotation/json_annotation.dart';

part 'finishbook.g.dart';

@JsonSerializable()
class FinishBook {
  int code;
  String msg;
  List<Data> data;

  FinishBook({this.code, this.msg, this.data});
  FinishBook.empty();

  factory FinishBook.fromJson(Map<String, dynamic> json) =>
      _$FinishBookFromJson(json);

  Map<String, dynamic> toJson() => _$FinishBookToJson(this);
}

@JsonSerializable()
class Data {
  int id;
  int userId;
  String userName;
  String bookName;
  int typeId;
  String title;
  String author;
  String url;
  String content;
  DateTime createTime;
  DateTime updateTime;
  int bookStatus;
  int bookId;
  int status;
  DateTime startTime;
  DateTime endTime;

  Data(
      {
        this.id,
        this.userId,
        this.userName,
        this.bookName,
        this.typeId,
        this.title,
        this.author,
        this.url,
        this.content,
        this.createTime,
        this.updateTime,
        this.bookStatus,
        this.bookId,
        this.status,
        this.startTime,
        this.endTime});



  factory Data.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

}


