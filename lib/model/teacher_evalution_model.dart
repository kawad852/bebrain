import 'package:bebrain/model/teacher_model.dart';

class TeacherEvalutionModel {
    bool? status;
    int? code;
    String? msg;
    List<Review>? data;

    TeacherEvalutionModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory TeacherEvalutionModel.fromJson(Map<String, dynamic> json) => TeacherEvalutionModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<Review>.from(json["data"]!.map((x) => Review.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}


