class ContinueLearningModel {
    bool? status;
    int? code;
    String? msg;
    List<LearningData>? data;

    ContinueLearningModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory ContinueLearningModel.fromJson(Map<String, dynamic> json) => ContinueLearningModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<LearningData>.from(json["data"]!.map((x) => LearningData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class LearningData {
    int? id;
    String? name;
    String? description;
    String? image;
    int? price;
    dynamic discountPrice;
    int? videosCount;
    int? unitsCount;
    int? percentage;
    int? hours;
    int? minutes;

    LearningData({
        this.id,
        this.name,
        this.description,
        this.image,
        this.price,
        this.discountPrice,
        this.videosCount,
        this.unitsCount,
        this.percentage,
        this.hours,
        this.minutes,
    });

    factory LearningData.fromJson(Map<String, dynamic> json) => LearningData(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        price: json["price"],
        discountPrice: json["discount_price"],
        videosCount: json["videos_count"],
        unitsCount: json["units_count"],
        percentage: json["percentage"],
        hours: json["hours"],
        minutes: json["minutes"],
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
        "percentage": percentage,
        "hours": hours,
        "minutes": minutes,
    };
}
