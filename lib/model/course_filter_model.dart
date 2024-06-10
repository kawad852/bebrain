import 'package:bebrain/model/country_filter_model.dart';

class CourseFilterModel {
    bool? status;
    int? code;
    String? msg;
    CourseFilterData? data;

    CourseFilterModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory CourseFilterModel.fromJson(Map<String, dynamic> json) => CourseFilterModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? null : CourseFilterData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data?.toJson(),
    };
}

class CourseFilterData {
    Course? course;
    List<dynamic>? moreCourses;

    CourseFilterData({
        this.course,
        this.moreCourses,
    });

    factory CourseFilterData.fromJson(Map<String, dynamic> json) => CourseFilterData(
        course: json["course"] == null ? null : Course.fromJson(json["course"]),
        moreCourses: json["more_courses"] == null ? [] : List<dynamic>.from(json["more_courses"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "course": course?.toJson(),
        "more_courses": moreCourses == null ? [] : List<dynamic>.from(moreCourses!.map((x) => x)),
    };
}

class Course {
    int? id;
    String? name;
    String? description;
    String? image;
    double? price;
    double? discountPrice;
    int? universityId;
    String? university;
    int? collegeId;
    String? college;
    int? majorId;
    String? major;
    int? videosCount;
    int? unitsCount;
    int? hours;
    int? minutes;
    Professor? professor;
    List<Unit>? units;

    Course({
        this.id,
        this.name,
        this.description,
        this.image,
        this.price,
        this.discountPrice,
        this.universityId,
        this.university,
        this.collegeId,
        this.college,
        this.majorId,
        this.major,
        this.videosCount,
        this.unitsCount,
        this.hours,
        this.minutes,
        this.professor,
        this.units,
    });

    factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        price: json["price"]?.toDouble(),
        discountPrice: json["discount_price"]?.toDouble(),
        universityId: json["university_id"],
        university: json["university"],
        collegeId: json["college_id"],
        college: json["college"],
        majorId: json["major_id"],
        major: json["major"],
        videosCount: json["videos_count"],
        unitsCount: json["units_count"],
        hours: json["hours"],
        minutes: json["minutes"],
        professor: json["professor"] == null ? null : Professor.fromJson(json["professor"]),
        units: json["units"] == null ? [] : List<Unit>.from(json["units"]!.map((x) => Unit.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "price": price,
        "discount_price": discountPrice,
        "university_id": universityId,
        "university": university,
        "college_id": collegeId,
        "college": college,
        "major_id": majorId,
        "major": major,
        "videos_count": videosCount,
        "units_count": unitsCount,
        "hours": hours,
        "minutes": minutes,
        "professor": professor?.toJson(),
        "units": units == null ? [] : List<dynamic>.from(units!.map((x) => x.toJson())),
    };
}


class Unit {
    int? id;
    String? name;
    int? tag;
    int? order;
    double? unitPrice;
    double? discountPrice;
    int? courseId;
    int? videosCount;
    int? documentsCount;
    int? videosMinutes;

    Unit({
        this.id,
        this.name,
        this.tag,
        this.order,
        this.unitPrice,
        this.discountPrice,
        this.courseId,
        this.videosCount,
        this.documentsCount,
        this.videosMinutes,
    });

    factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        id: json["id"],
        name: json["name"],
        tag: json["tag"],
        order: json["order"],
        unitPrice: json["unit_price"]?.toDouble(),
        discountPrice: json["discount_price"]?.toDouble(),
        courseId: json["course_id"],
        videosCount: json["videos_count"],
        documentsCount: json["documents_count"],
        videosMinutes: json["videos_minutes"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "tag": tag,
        "order": order,
        "unit_price": unitPrice,
        "discount_price": discountPrice,
        "course_id": courseId,
        "videos_count": videosCount,
        "documents_count": documentsCount,
        "videos_minutes": videosMinutes,
    };
}