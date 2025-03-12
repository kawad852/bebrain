import 'package:bebrain/model/course_filter_model.dart';

class CourseInfoModel {
    bool? status;
    int? code;
    String? msg;
    Data? data;

    CourseInfoModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory CourseInfoModel.fromJson(Map<String, dynamic> json) => CourseInfoModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data?.toJson(),
    };
}

class Data {
    Course? course;

    Data({
        this.course,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        course: json["course"] == null ? null : Course.fromJson(json["course"]),
    );

    Map<String, dynamic> toJson() => {
        "course": course?.toJson(),
    };
}

