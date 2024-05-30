class PolicyModel {
    bool? status;
    int? code;
    String? msg;
    PolicyData? data;

    PolicyModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory PolicyModel.fromJson(Map<String, dynamic> json) => PolicyModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? null : PolicyData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data?.toJson(),
    };
}

class PolicyData {
    int? id;
    String? title;
    String? description;

    PolicyData({
        this.id,
        this.title,
        this.description,
    });

    factory PolicyData.fromJson(Map<String, dynamic> json) => PolicyData(
        id: json["id"],
        title: json["title"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
    };
}
