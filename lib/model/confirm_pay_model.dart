class ConfirmPayModel {
    bool? status;
    int? code;
    String? msg;

    ConfirmPayModel({
        this.status,
        this.code,
        this.msg,
    });

    factory ConfirmPayModel.fromJson(Map<String, dynamic> json) => ConfirmPayModel(
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
