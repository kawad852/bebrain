import 'package:bebrain/model/new_request_model.dart';
import 'package:bebrain/model/subscriptions_model.dart';

class InterviewModel {
    bool? status;
    int? code;
    String? msg;
    List<InterviewData>? data;

    InterviewModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory InterviewModel.fromJson(Map<String, dynamic> json) => InterviewModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<InterviewData>.from(json["data"]!.map((x) => InterviewData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class InterviewData {
    int? id;
    int? userId;
    String? userName;
    int? professorId;
    String? professorName;
    int? subjectId;
    String? subjectName;
    String? interviewNumber;
    String? topic;
    double? price;
    int? paymentStatus;
    String? note;
    String? reply;
    String? status;
    String? statusType;
    DateTime? paymentDueDate;
    DateTime? createdDate;
    String? createdTime;
    DateTime? meetingDate;
    String? meetingTime;
    String? meetingId;
    String? meetingPassword;
    int? meetingPeriod;
    String? joinUrl;
    String? productId;
    Order? myOrder;
    List<UserAttachment>? userAttachment;
    List<UserAttachment>? adminAttachment;

    InterviewData({
        this.id,
        this.userId,
        this.userName,
        this.professorId,
        this.professorName,
        this.subjectId,
        this.subjectName,
        this.interviewNumber,
        this.topic,
        this.price,
        this.paymentStatus,
        this.note,
        this.reply,
        this.status,
        this.statusType,
        this.paymentDueDate,
        this.createdDate,
        this.createdTime,
        this.meetingDate,
        this.meetingTime,
        this.meetingId,
        this.meetingPassword,
        this.meetingPeriod,
        this.joinUrl,
        this.productId,
        this.myOrder,
        this.userAttachment,
        this.adminAttachment,
    });

    factory InterviewData.fromJson(Map<String, dynamic> json) => InterviewData(
        id: json["id"],
        userId: json["user_id"],
        userName: json["user_name"],
        professorId: json["professor_id"],
        professorName: json["professor_name"],
        subjectId: json["subject_id"],
        subjectName: json["subject_name"],
        interviewNumber: json["interview_number"],
        topic: json["topic"],
        price: json["price"]?.toDouble(),
        paymentStatus: json["payment_status"],
        note: json["note"],
        reply: json["reply"],
        status: json["status"],
        statusType: json["status_type"],
        paymentDueDate: json["payment_due_date"] == null ? null : DateTime.parse(json["payment_due_date"]),
        createdDate: json["created_date"] == null ? null : DateTime.parse(json["created_date"]),
        createdTime: json["created_time"],
        meetingDate: json["meeting_date"] == null ? null : DateTime.parse(json["meeting_date"]),
        meetingTime: json["meeting_time"],
        meetingId: json["meeting_id"],
        meetingPassword: json["meeting_password"],
        meetingPeriod: json["meeting_period"],
        joinUrl: json["join_url"],
        productId: json["product_id"],
        myOrder: json["my_order"] == null ? null : Order.fromJson(json["my_order"]),
        userAttachment: json["user_attachment"] == null ? [] : List<UserAttachment>.from(json["user_attachment"]!.map((x) => UserAttachment.fromJson(x))),
        adminAttachment: json["admin_attachment"] == null ? [] : List<UserAttachment>.from(json["admin_attachment"]!.map((x) => UserAttachment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_name": userName,
        "professor_id": professorId,
        "professor_name": professorName,
        "subject_id": subjectId,
        "subject_name": subjectName,
        "interview_number": interviewNumber,
        "topic": topic,
        "price": price,
        "payment_status": paymentStatus,
        "note": note,
        "reply": reply,
        "status": status,
        "status_type": statusType,
        "payment_due_date": paymentDueDate?.toIso8601String(),
        "created_date": "${createdDate!.year.toString().padLeft(4, '0')}-${createdDate!.month.toString().padLeft(2, '0')}-${createdDate!.day.toString().padLeft(2, '0')}",
        "created_time": createdTime,
        "meeting_date": "${meetingDate!.year.toString().padLeft(4, '0')}-${meetingDate!.month.toString().padLeft(2, '0')}-${meetingDate!.day.toString().padLeft(2, '0')}",
        "meeting_time": meetingTime,
        "meeting_id": meetingId,
        "meeting_password": meetingPassword,
        "meeting_period": meetingPeriod,
        "join_url": joinUrl,
        "product_id": productId,
        "my_order": myOrder?.toJson(),
        "user_attachment": userAttachment == null ? [] : List<dynamic>.from(userAttachment!.map((x) => x.toJson())),
        "admin_attachment": adminAttachment == null ? [] : List<dynamic>.from(adminAttachment!.map((x) => x.toJson())),
    };
}


