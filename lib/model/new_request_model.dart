class NewRequestModel {
    bool? status;
    int? code;
    String? msg;
    NewRequestData? data;

    NewRequestModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory NewRequestModel.fromJson(Map<String, dynamic> json) => NewRequestModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? null : NewRequestData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data?.toJson(),
    };
}

class NewRequestData {
    int? id;
    int? userId;
    String? userName;
    String? requestNumber;
    int? countryId;
    String? country;
    String? countryCode;
    int? universityId;
    String? universityName;
    int? collegeId;
    String? collegeName;
    int? majorId;
    String? majorName;
    String? title;
    double? price;
    int? paymentStatus;
    String? note;
    dynamic reply;
    String? status;
    String? statusType;
    List<UserAttachment>? userAttachment;
    List<UserAttachment>? adminAttachment;
    List<Videos>? videos;

    NewRequestData({
        this.id,
        this.userId,
        this.userName,
        this.requestNumber,
        this.countryId,
        this.country,
        this.countryCode,
        this.universityId,
        this.universityName,
        this.collegeId,
        this.collegeName,
        this.majorId,
        this.majorName,
        this.title,
        this.price,
        this.paymentStatus,
        this.note,
        this.reply,
        this.status,
        this.statusType,
        this.userAttachment,
        this.adminAttachment,
        this.videos,
    });

    factory NewRequestData.fromJson(Map<String, dynamic> json) => NewRequestData(
        id: json["id"],
        userId: json["user_id"],
        userName: json["user_name"],
        requestNumber: json["request_number"],
        countryId: json["country_id"],
        country: json["country"],
        countryCode: json["country_code"],
        universityId: json["university_id"],
        universityName: json["university_name"],
        collegeId: json["college_id"],
        collegeName: json["college_name"],
        majorId: json["major_id"],
        majorName: json["major_name"],
        title: json["title"],
        price: json["price"]?.toDouble(),
        paymentStatus: json["payment_status"],
        note: json["note"],
        reply: json["reply"],
        status: json["status"],
        statusType: json["status_type"],
        userAttachment: json["user_attachment"] == null ? [] : List<UserAttachment>.from(json["user_attachment"]!.map((x) => UserAttachment.fromJson(x))),
        adminAttachment: json["admin_attachment"] == null ? [] : List<UserAttachment>.from(json["admin_attachment"]!.map((x) => UserAttachment.fromJson(x))),
        videos: json["videos"] == null ? [] : List<Videos>.from(json["videos"]!.map((x) => Videos.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_name": userName,
        "request_number": requestNumber,
        "country_id": countryId,
        "country": country,
        "country_code": countryCode,
        "university_id": universityId,
        "university_name": universityName,
        "college_id": collegeId,
        "college_name": collegeName,
        "major_id": majorId,
        "major_name": majorName,
        "title": title,
        "price": price,
        "payment_status": paymentStatus,
        "note": note,
        "reply": reply,
        "status": status,
        "status_type": statusType,
        "user_attachment": userAttachment == null ? [] : List<dynamic>.from(userAttachment!.map((x) => x.toJson())),
        "admin_attachment": adminAttachment == null ? [] : List<dynamic>.from(adminAttachment!.map((x) => x.toJson())),
        "videos": videos == null ? [] : List<dynamic>.from(videos!.map((x) => x.toJson())),
    };
}

class UserAttachment {
    int? id;
    String? attachment;

    UserAttachment({
        this.id,
        this.attachment,
    });

    factory UserAttachment.fromJson(Map<String, dynamic> json) => UserAttachment(
        id: json["id"],
        attachment: json["attachment"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "attachment": attachment,
    };
}

class Videos {
    String? vimeoId;

    Videos({
        this.vimeoId,
    });

    factory Videos.fromJson(Map<String, dynamic> json) => Videos(
        vimeoId: json["vimeo_id"],
    );

    Map<String, dynamic> toJson() => {
        "vimeo_id": vimeoId,
    };
}
