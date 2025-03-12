import 'package:bebrain/model/country_filter_model.dart' as co;
class MoreCourseModel {
    bool? status;
    int? code;
    String? msg;
    Data? data;

    MoreCourseModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory MoreCourseModel.fromJson(Map<String, dynamic> json) => MoreCourseModel(
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
    List<co.Course>? moreCourses;

    Data({
        this.moreCourses,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        moreCourses: json["more_courses"] == null ? [] : List<co.Course>.from(json["more_courses"]!.map((x) => co.Course.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "more_courses": moreCourses == null ? [] : List<dynamic>.from(moreCourses!.map((x) => x.toJson())),
    };
}

