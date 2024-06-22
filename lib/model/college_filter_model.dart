
import 'package:bebrain/model/country_filter_model.dart';

class CollegeFilterModel {
    bool? status;
    int? code;
    String? msg;
    CollegeFilterData? data;

    CollegeFilterModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory CollegeFilterModel.fromJson(Map<String, dynamic> json) => CollegeFilterModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? null : CollegeFilterData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data?.toJson(),
    };
}

class CollegeFilterData {
    College? college;
    List<Major>? majors;
    List<Professor>? professors;

    CollegeFilterData({
        this.college,
        this.majors,
        this.professors,
    });

    factory CollegeFilterData.fromJson(Map<String, dynamic> json) => CollegeFilterData(
        college: json["college"] == null ? null : College.fromJson(json["college"]),
        majors: json["majors"] == null ? [] : List<Major>.from(json["majors"]!.map((x) => Major.fromJson(x))),
        professors: json["professors"] == null ? [] : List<Professor>.from(json["professors"]!.map((x) => Professor.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "college": college?.toJson(),
        "majors": majors == null ? [] : List<dynamic>.from(majors!.map((x) => x.toJson())),
        "professors": professors == null ? [] : List<dynamic>.from(professors!.map((x) => x.toJson())),
    };
}


class Major {
    int? id;
    String? name;
    int? totalSubscriptions;
    List<Course>? courses;

    Major({
        this.id,
        this.name,
        this.totalSubscriptions,
        this.courses,
    });

    factory Major.fromJson(Map<String, dynamic> json) => Major(
        id: json["id"],
        name: json["name"],
        totalSubscriptions: json["total_subscriptions"],
        courses: json["courses"] == null ? [] : List<Course>.from(json["courses"]!.map((x) => Course.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "total_subscriptions": totalSubscriptions,
        "courses": courses == null ? [] : List<dynamic>.from(courses!.map((x) => x.toJson())),
    };
}
