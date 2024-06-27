class VideoViewModel {
    bool? status;
    int? code;
    String? msg;
    Data? data;

    VideoViewModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory VideoViewModel.fromJson(Map<String, dynamic> json) => VideoViewModel(
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
    int? userId;
    int? courseId;
    int? videoId;
    DateTime? createdAt;
    DateTime? updatedAt;

    Data({
        this.id,
        this.userId,
        this.courseId,
        this.videoId,
        this.createdAt,
        this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        courseId: json["course_id"],
        videoId: json["video_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "course_id": courseId,
        "video_id": videoId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
