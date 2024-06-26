class CountryFilterModel {
    bool? status;
    int? code;
    String? msg;
    CountryFilterData? data;

    CountryFilterModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory CountryFilterModel.fromJson(Map<String, dynamic> json) => CountryFilterModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? null : CountryFilterData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data?.toJson(),
    };
}

class CountryFilterData {
    List<University>? universities;
    List<Professor>? professors;

    CountryFilterData({
        this.universities,
        this.professors,
    });

    factory CountryFilterData.fromJson(Map<String, dynamic> json) => CountryFilterData(
        universities: json["universities"] == null ? [] : List<University>.from(json["universities"]!.map((x) => University.fromJson(x))),
        professors: json["professors"] == null ? [] : List<Professor>.from(json["professors"]!.map((x) => Professor.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "universities": universities == null ? [] : List<dynamic>.from(universities!.map((x) => x.toJson())),
        "professors": professors == null ? [] : List<dynamic>.from(professors!.map((x) => x.toJson())),
    };
}

class Professor {
    int? id;
    String? name;
    String? description;
    String? image;
    int? subscriptionCount;
    double? reviewsRating;
    int? reviewsCount;
    int? coursesCount;
    int? viewsCount;

    Professor({
        this.id,
        this.name,
        this.description,
        this.image,
        this.subscriptionCount,
        this.reviewsRating,
        this.reviewsCount,
        this.coursesCount,
        this.viewsCount,
    });

    factory Professor.fromJson(Map<String, dynamic> json) => Professor(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        subscriptionCount: json["subscription_count"],
        reviewsRating: json["reviews_rating"]?.toDouble(),
        reviewsCount: json['reviews_count'],
        coursesCount: json["courses_count"],
        viewsCount: json["views_count"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "subscription_count": subscriptionCount,
        "reviews_rating": reviewsRating,
        "reviews_count": reviewsCount,
        "courses_count": coursesCount,
        "views_count": viewsCount,
    };
}

class University {
    int? id;
    String? name;
    int? countryId;
    String? country;
    List<Course>? courses;
    List<College>? colleges;

    University({
        this.id,
        this.name,
        this.countryId,
        this.country,
        this.courses,
        this.colleges,
    });

    factory University.fromJson(Map<String, dynamic> json) => University(
        id: json["id"],
        name: json["name"],
        countryId: json["country_id"],
        country: json["country"],
        courses: json["courses"] == null ? [] : List<Course>.from(json["courses"]!.map((x) => Course.fromJson(x))),
        colleges: json["colleges"] == null ? [] : List<College>.from(json["colleges"]!.map((x) => College.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_id": countryId,
        "country": country,
        "courses": courses == null ? [] : List<dynamic>.from(courses!.map((x) => x.toJson())),
        "colleges": colleges == null ? [] : List<dynamic>.from(colleges!.map((x) => x.toJson())),
    };
}

class College {
    int? id;
    String? name;

    College({
        this.id,
        this.name,
    });

    factory College.fromJson(Map<String, dynamic> json) => College(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class Course {
    int? id;
    String? name;
    String? description;
    String? image;
    double? price;
    double? discountPrice;
    int? videosCount;
    int? unitCount;
    int? collegeId;
    String? college;
    int? majorId;
    String? major;
    int? subscriptionCount;
    double? reviewsRating;
    int? professorId;
    String? professor;

    Course({
        this.id,
        this.name,
        this.description,
        this.image,
        this.price,
        this.discountPrice,
        this.videosCount,
        this.unitCount,
        this.collegeId,
        this.college,
        this.majorId,
        this.major,
        this.subscriptionCount,
        this.reviewsRating,
        this.professorId,
        this.professor,
    });

    factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        price: json["price"]?.toDouble(),
        discountPrice: json["discount_price"]?.toDouble(),
        videosCount: json['videos_count'],
        unitCount: json['units_count'],
        collegeId: json["college_id"],
        college: json["college"],
        majorId: json["major_id"],
        major: json["major"],
        subscriptionCount: json["subscription_count"],
        professorId: json["professor_id"],
        reviewsRating: json["reviews_rating"]?.toDouble(),
        professor: json["professor"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "price": price,
        "discount_price": discountPrice,
        "videos_count":videosCount,
        "units_count":unitCount,
        "college_id": collegeId,
        "college": college,
        "major_id": majorId,
        "major": major,
        "subscription_count": subscriptionCount,
        "reviews_rating": reviewsRating,
        "professor_id": professorId,
        "professor": professor,
    };
}
