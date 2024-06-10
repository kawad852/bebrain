import 'package:bebrain/model/new_request_model.dart';

class ProjectsModel {
    bool? status;
    int? code;
    String? msg;
    List<RequestData>? data;

    ProjectsModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory ProjectsModel.fromJson(Map<String, dynamic> json) => ProjectsModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<RequestData>.from(json["data"]!.map((x) => RequestData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

