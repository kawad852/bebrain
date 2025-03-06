import 'package:bebrain/model/teacher_model.dart';

class ProfessorCourseModel {
    bool? status;
    int? code;
    String? msg;
    Data? data;

    ProfessorCourseModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory ProfessorCourseModel.fromJson(Map<String, dynamic> json) => ProfessorCourseModel(
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
    int? id;
    String? name;
    String? email;
    double? interviewHourPrice;
    String? description;
    String? image;
    int? reviewsCount;
    double? reviewsRating;
    int? subscriptionCount;
    int? coursesCount;
    int? viewsCount;
    int? videosCount;
    String? vimeoId;
    List<Subject>? subjects;
    List<InterviewDay>? interviewDays;

    Data({
        this.id,
        this.name,
        this.email,
        this.interviewHourPrice,
        this.description,
        this.image,
        this.reviewsCount,
        this.reviewsRating,
        this.subscriptionCount,
        this.coursesCount,
        this.viewsCount,
        this.videosCount,
        this.vimeoId,
        this.subjects,
        this.interviewDays,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        interviewHourPrice: json["interview_hour_price"]?.toDouble(),
        description: json["description"],
        image: json["image"],
        reviewsCount: json["reviews_count"],
        reviewsRating: json["reviews_rating"]?.toDouble(),
        subscriptionCount: json["subscription_count"],
        coursesCount: json["courses_count"],
        viewsCount: json["views_count"],
        videosCount: json["videos_count"],
        vimeoId: json["vimeo_id"],
        subjects: json["subjects"] == null ? [] : List<Subject>.from(json["subjects"]!.map((x) => Subject.fromJson(x))),
        interviewDays: json["interview_days"] == null ? [] : List<InterviewDay>.from(json["interview_days"]!.map((x) => InterviewDay.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "interview_hour_price": interviewHourPrice,
        "description": description,
        "image": image,
        "reviews_count": reviewsCount,
        "reviews_rating": reviewsRating,
        "subscription_count": subscriptionCount,
        "courses_count": coursesCount,
        "views_count": viewsCount,
        "videos_count": videosCount,
        "vimeo_id": vimeoId,
        "subjects": subjects == null ? [] : List<dynamic>.from(subjects!.map((x) => x.toJson())),
        "interview_days": interviewDays == null ? [] : List<dynamic>.from(interviewDays!.map((x) => x.toJson())),
    };
}



