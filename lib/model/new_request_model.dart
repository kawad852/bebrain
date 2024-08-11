import 'package:bebrain/model/subscriptions_model.dart';

class NewRequestModel {
    bool? status;
    int? code;
    String? msg;
    RequestData? data;

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
        data: json["data"] == null ? null : RequestData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data?.toJson(),
    };
}

class RequestData {
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
    String? reply;
    String? status;
    String? statusType;
    DateTime? paymentDueDate;
    String? createdDate;
    String? createdTime;
    String? replyDate;
    String? replyTime;
    String? productId;
    Order? myOrder;
    List<UserAttachment>? userAttachment;
    List<UserAttachment>? adminAttachment;
    List<Videos>? videos;

    RequestData({
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
        this.paymentDueDate,
        this.createdDate,
        this.createdTime,
        this.replyDate,
        this.replyTime,
        this.productId,
        this.myOrder,
        this.userAttachment,
        this.adminAttachment,
        this.videos,
    });

    factory RequestData.fromJson(Map<String, dynamic> json) => RequestData(
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
        paymentDueDate: json["payment_due_date"] == null ? null : DateTime.parse(json["payment_due_date"]),
        createdDate: json["created_date"],
        createdTime: json["created_time"],
        replyDate: json["reply_date"],
        replyTime: json["reply_time"],
        productId: json["product_id"],
        myOrder: json["my_order"] == null ? null : Order.fromJson(json["my_order"]),
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
        "payment_due_date": paymentDueDate?.toIso8601String(),
        "created_date": createdDate,
        "created_time": createdTime,
        "reply_date": replyDate,
        "reply_time": replyTime,
        "product_id": productId,
        "my_order": myOrder?.toJson(),
        "user_attachment": userAttachment == null ? [] : List<dynamic>.from(userAttachment!.map((x) => x.toJson())),
        "admin_attachment": adminAttachment == null ? [] : List<dynamic>.from(adminAttachment!.map((x) => x.toJson())),
        "videos": videos == null ? [] : List<dynamic>.from(videos!.map((x) => x.toJson())),
    };
}

class UserAttachment {
    int? id;
    String? attachment;
    String? filename;

    UserAttachment({
        this.id,
        this.attachment,
        this.filename,
    });

    factory UserAttachment.fromJson(Map<String, dynamic> json) => UserAttachment(
        id: json["id"],
        attachment: json["attachment"],
        filename: json["filename"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "attachment": attachment,
        "filename": filename,
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
