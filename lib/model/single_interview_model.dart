import 'package:bebrain/model/interview_model.dart';

class SingleInterviewModel {
    bool? status;
    int? code;
    String? msg;
    InterviewData? data;

    SingleInterviewModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory SingleInterviewModel.fromJson(Map<String, dynamic> json) => SingleInterviewModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? null : InterviewData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data?.toJson(),
    };
}


