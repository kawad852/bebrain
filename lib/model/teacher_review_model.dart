import 'package:bebrain/model/teacher_model.dart';

class TeacherReviewModel {
    bool? status;
    int? code;
    String? msg;
    Review? data;

    TeacherReviewModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory TeacherReviewModel.fromJson(Map<String, dynamic> json) => TeacherReviewModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? null : Review.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data?.toJson(),
    };
}


