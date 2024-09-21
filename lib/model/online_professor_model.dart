import 'package:bebrain/model/teacher_model.dart';

class OnlineProfessorModel {
    bool? status;
    int? code;
    String? msg;
    List<TeacherData>? data;

    OnlineProfessorModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory OnlineProfessorModel.fromJson(Map<String, dynamic> json) => OnlineProfessorModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<TeacherData>.from(json["data"]!.map((x) => TeacherData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

