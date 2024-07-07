import 'package:bebrain/model/subscriptions_model.dart';

class OrderModel {
    bool? status;
    int? code;
    String? msg;
    Order? data;

    OrderModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? null : Order.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data?.toJson(),
    };
}