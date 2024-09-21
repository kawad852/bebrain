import 'package:bebrain/model/teacher_model.dart';

class ImportantSubjectModel {
    bool? status;
    int? code;
    String? msg;
    List<Subject>? data;

    ImportantSubjectModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory ImportantSubjectModel.fromJson(Map<String, dynamic> json) => ImportantSubjectModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<Subject>.from(json["data"]!.map((x) => Subject.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

