class SliderModel {
    bool? status;
    int? code;
    String? msg;
    List<SliderData>? data;

    SliderModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<SliderData>.from(json["data"]!.map((x) => SliderData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class SliderData {
    int? id;
    String? image;
    int? courseId;
    String? courseName;

    SliderData({
        this.id,
        this.image,
        this.courseId,
        this.courseName,
    });

    factory SliderData.fromJson(Map<String, dynamic> json) => SliderData(
        id: json["id"],
        image: json["image"],
        courseId: json["course_id"],
        courseName: json["course_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "course_id": courseId,
        "course_name": courseName,
    };
}
