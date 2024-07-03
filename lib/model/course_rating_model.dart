class CourseRatingModel {
    bool? status;
    int? code;
    String? msg;
    Data? data;

    CourseRatingModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory CourseRatingModel.fromJson(Map<String, dynamic> json) => CourseRatingModel(
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
    int? courseId;
    int? userId;
    String? comment;
    DateTime? createdAt;
    String? rating;
    String? audioVideoQuality;
    String? valueForMoney;
    String? conveyIdea;
    String? similarityCurriculumContent;

    Data({
        this.id,
        this.courseId,
        this.userId,
        this.comment,
        this.createdAt,
        this.rating,
        this.audioVideoQuality,
        this.valueForMoney,
        this.conveyIdea,
        this.similarityCurriculumContent,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        courseId: json["course_id"],
        userId: json["user_id"],
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
        "comment": comment,
        "created_at": createdAt?.toIso8601String(),
        "rating": rating,
        "audio_video_quality": audioVideoQuality,
        "value_for_money": valueForMoney,
        "convey_idea": conveyIdea,
        "similarity_curriculum_content": similarityCurriculumContent,
    };
}
