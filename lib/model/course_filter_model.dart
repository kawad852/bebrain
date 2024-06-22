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
    int? subscriptionCount;
    Professor? professor;
    Offer? offer;
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
        this.subscriptionCount,
        this.professor,
        this.offer,
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
        subscriptionCount: json["subscription_count"],
        professor: json["professor"] == null ? null : Professor.fromJson(json["professor"]),
        offer: json["offer"] == null ? null : Offer.fromJson(json["offer"]),
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
        "subscription_count": subscriptionCount,
        "professor": professor?.toJson(),
        "offer": offer?.toJson(),
        "units": units == null ? [] : List<dynamic>.from(units!.map((x) => x.toJson())),
    };
}


class Offer {
    int? id;
    String? content;
    DateTime? startDate;
    DateTime? endDate;

    Offer({
        this.id,
        this.content,
        this.startDate,
        this.endDate,
    });

    factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["id"],
        content: json["content"],
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
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
    int? subscriptionCount;
    Offer? offer;

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
        this.subscriptionCount,
        this.offer,
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
        subscriptionCount: json["subscription_count"],
        offer: json["offer"] == null ? null : Offer.fromJson(json["offer"]),
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
        "subscription_count": subscriptionCount,
        "offer": offer?.toJson(),
    };
}
