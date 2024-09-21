class SubscriptionsModel {
    bool? status;
    int? code;
    String? msg;
    SubscriptionsData? data;

    SubscriptionsModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory SubscriptionsModel.fromJson(Map<String, dynamic> json) => SubscriptionsModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? null : SubscriptionsData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data?.toJson(),
    };
}

class SubscriptionsData {
    int? id;
    String? type;
    int? typeId;
    DateTime? createdAt;
    Period? period;
    Order? order;

    SubscriptionsData({
        this.id,
        this.type,
        this.typeId,
        this.createdAt,
        this.period,
        this.order,
    });

    factory SubscriptionsData.fromJson(Map<String, dynamic> json) => SubscriptionsData(
        id: json["id"],
        type: json["type"],
        typeId: json["type_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        period: json["period"] == null ? null : Period.fromJson(json["period"]),
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "type_id": typeId,
        "created_at": createdAt?.toIso8601String(),
        "period": period?.toJson(),
        "order": order?.toJson(),
    };
}

class Order {
    int? id;
    double? amount;
    DateTime? createdAt;
    int? userId;
    String? userName;
    String? userImage;
    String? status;
    String? orderNumber;
    String? type;
    int? typeId;

    Order({
        this.id,
        this.amount,
        this.createdAt,
        this.userId,
        this.userName,
        this.userImage,
        this.status,
        this.orderNumber,
        this.type,
        this.typeId,
    });

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        amount: json["amount"].toDouble(),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        userId: json["user_id"],
        userName: json["user_name"],
        userImage: json["user_image"],
        status: json["status"],
        orderNumber: json["order_number"],
        type: json["type"],
        typeId: json["type_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "created_at": createdAt?.toIso8601String(),
        "user_id": userId,
        "user_name": userName,
        "user_image": userImage,
        "status": status,
        "order_number": orderNumber,
        "type": type,
        "type_id": typeId,
    };
}

class Period {
    int? id;
    String? name;
    DateTime? from;
    DateTime? to;

    Period({
        this.id,
        this.name,
        this.from,
        this.to,
    });

    factory Period.fromJson(Map<String, dynamic> json) => Period(
        id: json["id"],
        name: json["name"],
        from: json["from"] == null ? null : DateTime.parse(json["from"]),
        to: json["to"] == null ? null : DateTime.parse(json["to"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "from": from?.toIso8601String(),
        "to": to?.toIso8601String(),
    };
}
