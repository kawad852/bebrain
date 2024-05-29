import 'package:bebrain/model/college_filter_model.dart';
import 'package:bebrain/model/country_filter_model.dart';

class MajorFilterModel {
    bool? status;
    int? code;
    String? msg;
    MajorFilterData? data;

    MajorFilterModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory MajorFilterModel.fromJson(Map<String, dynamic> json) => MajorFilterModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? null : MajorFilterData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data?.toJson(),
    };
}

class MajorFilterData {
    int? courseCount;
    Major? major;
    List<Professor>? professors;

    MajorFilterData({
        this.courseCount,
        this.major,
        this.professors,
    });

    factory MajorFilterData.fromJson(Map<String, dynamic> json) => MajorFilterData(
        courseCount: json["course_count"],
        major: json["major"] == null ? null : Major.fromJson(json["major"]),
        professors: json["professors"] == null ? [] : List<Professor>.from(json["professors"]!.map((x) => Professor.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "course_count": courseCount,
        "major": major?.toJson(),
        "professors": professors == null ? [] : List<dynamic>.from(professors!.map((x) => x.toJson())),
    };
}





