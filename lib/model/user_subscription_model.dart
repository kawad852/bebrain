class UserSubscriptionModel {
    bool? status;
    int? code;
    String? msg;
    List<Datum>? data;

    UserSubscriptionModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory UserSubscriptionModel.fromJson(Map<String, dynamic> json) => UserSubscriptionModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    int? id;
    String? name;
    String? description;
    String? image;
    double? price;
    double? discountPrice;
    int? videosCount;
    int? unitsCount;
    int? universityId;
    int? university;
    int? collegeId;
    String? college;
    int? majorId;
    String? major;
    int? reviewsCount;
    double? reviewsRating;
    double? audioVideoQuality;
    double? valueForMoney;
    double? conveyIdea;
    double? similarityCurriculumContent;
    int? available;
    int? viewsCount;
    int? professorId;
    String? professor;
    List<Subscription>? subscriptions;

    Datum({
        this.id,
        this.name,
        this.description,
        this.image,
        this.price,
        this.discountPrice,
        this.videosCount,
        this.unitsCount,
        this.universityId,
        this.university,
        this.collegeId,
        this.college,
        this.majorId,
        this.major,
        this.reviewsCount,
        this.reviewsRating,
        this.audioVideoQuality,
        this.valueForMoney,
        this.conveyIdea,
        this.similarityCurriculumContent,
        this.available,
        this.viewsCount,
        this.professorId,
        this.professor,
        this.subscriptions,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        price: json["price"]?.toDouble(),
        discountPrice: json["discount_price"]?.toDouble(),
        videosCount: json["videos_count"],
        unitsCount: json["units_count"],
        universityId: json["university_id"],
        university: json["university"],
        collegeId: json["college_id"],
        college: json["college"],
        majorId: json["major_id"],
        major: json["major"],
        reviewsCount: json["reviews_count"],
        reviewsRating: json["reviews_rating"]?.toDouble(),
        audioVideoQuality: json["audio_video_quality"]?.toDouble(),
        valueForMoney: json["value_for_money"]?.toDouble(),
        conveyIdea: json["convey_idea"]?.toDouble(),
        similarityCurriculumContent: json["similarity_curriculum_content"]?.toDouble(),
        available: json["available"],
        viewsCount: json["views_count"],
        professorId: json["professor_id"],
        professor: json["professor"],
        subscriptions: json["subscriptions"] == null ? [] : List<Subscription>.from(json["subscriptions"]!.map((x) => Subscription.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "price": price,
        "discount_price": discountPrice,
        "videos_count": videosCount,
        "units_count": unitsCount,
        "university_id": universityId,
        "university": university,
        "college_id": collegeId,
        "college": college,
        "major_id": majorId,
        "major": major,
        "reviews_count": reviewsCount,
        "reviews_rating": reviewsRating,
        "audio_video_quality": audioVideoQuality,
        "value_for_money": valueForMoney,
        "convey_idea": conveyIdea,
        "similarity_curriculum_content": similarityCurriculumContent,
        "available": available,
        "views_count": viewsCount,
        "professor_id": professorId,
        "professor": professor,
        "subscriptions": subscriptions == null ? [] : List<dynamic>.from(subscriptions!.map((x) => x.toJson())),
    };
}

class Subscription {
    int? id;
    String? type;
    int? typeId;
    DateTime? createdAt;
    Period? period;
    Order? order;

    Subscription({
        this.id,
        this.type,
        this.typeId,
        this.createdAt,
        this.period,
        this.order,
    });

    factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
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
