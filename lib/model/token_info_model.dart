class TokenInfoModel {
    bool? status;
    int? code;
    String? msg;

    TokenInfoModel({
        this.status,
        this.code,
        this.msg,
    });

    factory TokenInfoModel.fromJson(Map<String, dynamic> json) => TokenInfoModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
    };
}
