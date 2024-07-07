class NotificationModel {
    bool? status;
    int? code;
    String? msg;
    List<NotificationData>? data;

    NotificationModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<NotificationData>.from(json["data"]!.map((x) => NotificationData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class NotificationData {
    int? id;
    String? title;
    String? content;
    dynamic userId;
    DateTime? createdAt;

    NotificationData({
        this.id,
        this.title,
        this.content,
        this.userId,
        this.createdAt,
    });

    factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        userId: json["user_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
    };
}
