class CourseReviewModel {
    bool? status;
    int? code;
    String? msg;
    List<ReviewData>? data;

    CourseReviewModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory CourseReviewModel.fromJson(Map<String, dynamic> json) => CourseReviewModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<ReviewData>.from(json["data"]!.map((x) => ReviewData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class ReviewData {
    int? id;
    int? courseId;
    int? userId;
    String? userName;
    String? userImage;
    String? comment;
    DateTime? createdAt;
    String? rating;
    String? audioVideoQuality;
    String? valueForMoney;
    String? conveyIdea;
    String? similarityCurriculumContent;

    ReviewData({
        this.id,
        this.courseId,
        this.userId,
        this.userName,
        this.userImage,
        this.comment,
        this.createdAt,
        this.rating,
        this.audioVideoQuality,
        this.valueForMoney,
        this.conveyIdea,
        this.similarityCurriculumContent,
    });

    factory ReviewData.fromJson(Map<String, dynamic> json) => ReviewData(
        id: json["id"],
        courseId: json["course_id"],
        userId: json["user_id"],
        userName: json["user_name"],
        userImage: json["user_image"],
        comment: json["comment"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        rating: json["rating"],
        audioVideoQuality: json["audio_video_quality"],
        valueForMoney: json["value_for_money"],
        conveyIdea: json["convey_idea"],
        similarityCurriculumContent: json["similarity_curriculum_content"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "course_id": courseId,
        "user_id": userId,
        "user_name": userName,
        "user_image": userImage,
        "comment": comment,
        "created_at": createdAt?.toIso8601String(),
        "rating": rating,
        "audio_video_quality": audioVideoQuality,
        "value_for_money": valueForMoney,
        "convey_idea": conveyIdea,
        "similarity_curriculum_content": similarityCurriculumContent,
    };
}
