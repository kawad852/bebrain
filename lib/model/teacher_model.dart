import 'package:bebrain/model/country_filter_model.dart';

class TeacherModel {
    bool? status;
    int? code;
    String? msg;
    TeacherData? data;

    TeacherModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory TeacherModel.fromJson(Map<String, dynamic> json) => TeacherModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? null : TeacherData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data?.toJson(),
    };
}

class TeacherData {
    int? id;
    String? name;
    String? email;
    String? description;
    String? image;
    int? universityId;
    String? universityName;
    int? reviewsCount;
    double? reviewsRating;
    int? subscriptionCount;
    int? viewsCount;
    int? videosCount;
    int? coursesCount;
    List<Major>? majors;
    List<College>? colleges;
    List<Course>? courses;
    List<Review>? reviews;
    List<Subject>? subjects;
    List<InterviewDay>? interviewDays;

    TeacherData({
        this.id,
        this.name,
        this.email,
        this.description,
        this.image,
        this.universityId,
        this.universityName,
        this.reviewsCount,
        this.reviewsRating,
        this.subscriptionCount,
        this.viewsCount,
        this.videosCount,
        this.coursesCount,
        this.majors,
        this.colleges,
        this.courses,
        this.reviews,
        this.subjects,
        this.interviewDays,
    });

    factory TeacherData.fromJson(Map<String, dynamic> json) => TeacherData(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        description: json["description"],
        image: json["image"],
        universityId: json["university_id"],
        universityName: json["university_name"]??'',
        reviewsCount: json["reviews_count"],
        reviewsRating: json["reviews_rating"]?.toDouble(),
        subscriptionCount: json["subscription_count"],
        viewsCount: json["views_count"],
        videosCount: json["videos_count"],
        coursesCount: json["courses_count"],
        majors: json["majors"] == null ? [] : List<Major>.from(json["majors"]!.map((x) => Major.fromJson(x))),
        colleges: json["colleges"] == null ? [] : List<College>.from(json["colleges"]!.map((x) => College.fromJson(x))),
        courses: json["courses"] == null ? [] : List<Course>.from(json["courses"]!.map((x) => Course.fromJson(x))),
        reviews: json["reviews"] == null ? [] : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
        subjects: json["subjects"] == null ? [] : List<Subject>.from(json["subjects"]!.map((x) => Subject.fromJson(x))),
        interviewDays: json["interview_days"] == null ? [] : List<InterviewDay>.from(json["interview_days"]!.map((x) => InterviewDay.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "description": description,
        "image": image,
        "university_id": universityId,
        "university_name": universityName,
        "reviews_count": reviewsCount,
        "reviews_rating": reviewsRating,
        "subscription_count": subscriptionCount,
        "views_count": viewsCount,
        "videos_count": videosCount,
        "courses_count": coursesCount,
        "majors": majors == null ? [] : List<dynamic>.from(majors!.map((x) => x.toJson())),
        "colleges": colleges == null ? [] : List<dynamic>.from(colleges!.map((x) => x.toJson())),
        "courses": courses == null ? [] : List<dynamic>.from(courses!.map((x) => x.toJson())),
        "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x.toJson())),
        "subjects": subjects == null ? [] : List<dynamic>.from(subjects!.map((x) => x.toJson())),
        "interview_days": interviewDays == null ? [] : List<dynamic>.from(interviewDays!.map((x) => x.toJson())),
    };
}

class College {
    int? id;
    String? name;
    int? universityId;
    String? university;

    College({
        this.id,
        this.name,
        this.universityId,
        this.university,
    });

    factory College.fromJson(Map<String, dynamic> json) => College(
        id: json["id"],
        name: json["name"],
        universityId: json["university_id"],
        university: json["university"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "university_id": universityId,
        "university": university,
    };
}



class Major {
    int? id;
    String? name;

    Major({
        this.id,
        this.name,
    });

    factory Major.fromJson(Map<String, dynamic> json) => Major(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class Review {
    int? id;
    int? professorId;
    int? userId;
    String? userName;
    String? userImage;
    String? comment;
    String? rating;
    DateTime? createdAt;

    Review({
        this.id,
        this.professorId,
        this.userId,
        this.userName,
        this.userImage,
        this.comment,
        this.rating,
        this.createdAt,
    });

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        professorId: json["professor_id"],
        userId: json["user_id"],
        userName: json["user_name"],
        userImage: json["user_image"],
        comment: json["comment"],
        rating: json["rating"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "professor_id": professorId,
        "user_id": userId,
        "user_name": userName,
        "user_image": userImage,
        "comment": comment,
        "rating": rating,
        "created_at": createdAt?.toIso8601String(),
    };
}

class Subject {
    int? id;
    String? name;

    Subject({
        this.id,
        this.name,
    });

    factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class InterviewDay {
    int? id;
    String? day;
    String? from;
    String? to;
    int? dayId;

    InterviewDay({
        this.id,
        this.day,
        this.from,
        this.to,
        this.dayId,
    });

    factory InterviewDay.fromJson(Map<String, dynamic> json) => InterviewDay(
        id: json["id"],
        day: json["day"],
        from: json["from"],
        to: json["to"],
        dayId: json["day_id"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "day": day,
        "from": from,
        "to": to,
        "day_id": dayId,
    };
}