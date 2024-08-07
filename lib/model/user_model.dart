import 'package:bebrain/model/auth_model.dart';

class UserModel {
  bool? status;
  int? code;
  String? msg;
  UserData? data;

  UserModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["user"] == null ? null : UserData.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "user": data?.toJson(),
      };
}
