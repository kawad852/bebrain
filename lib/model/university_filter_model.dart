class UniversityFilterModel {
    bool? status;
    int? code;
    String? msg;
    UniversityFilterData? data;

    UniversityFilterModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory UniversityFilterModel.fromJson(Map<String, dynamic> json) => UniversityFilterModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? null : UniversityFilterData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data?.toJson(),
    };
}

class UniversityFilterData {
    University? university;
    List<Professor>? professors;

    UniversityFilterData({
        this.university,
        this.professors,
    });

    factory UniversityFilterData.fromJson(Map<String, dynamic> json) => UniversityFilterData(
        university: json["university"] == null ? null : University.fromJson(json["university"]),
        professors: json["professors"] == null ? [] : List<Professor>.from(json["professors"]!.map((x) => Professor.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "university": university?.toJson(),
        "professors": professors == null ? [] : List<dynamic>.from(professors!.map((x) => x.toJson())),
    };
}

class Professor {
    int? id;
    String? name;
    String? description;
    String? image;

    Professor({
        this.id,
        this.name,
        this.description,
        this.image,
    });

    factory Professor.fromJson(Map<String, dynamic> json) => Professor(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
    };
}

class University {
    int? id;
    String? name;
    int? countryId;
    String? country;
    List<College>? colleges;

    University({
        this.id,
        this.name,
        this.countryId,
        this.country,
        this.colleges,
    });

    factory University.fromJson(Map<String, dynamic> json) => University(
        id: json["id"],
        name: json["name"],
        countryId: json["country_id"],
        country: json["country"],
        colleges: json["colleges"] == null ? [] : List<College>.from(json["colleges"]!.map((x) => College.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_id": countryId,
        "country": country,
        "colleges": colleges == null ? [] : List<dynamic>.from(colleges!.map((x) => x.toJson())),
    };
}

class College {
    int? id;
    String? name;
    List<Course>? courses;
    List<Major>? majors;

    College({
        this.id,
        this.name,
        this.courses,
        this.majors,
    });

    factory College.fromJson(Map<String, dynamic> json) => College(
        id: json["id"],
        name: json["name"],
        courses: json["courses"] == null ? [] : List<Course>.from(json["courses"]!.map((x) => Course.fromJson(x))),
        majors: json["majors"] == null ? [] : List<Major>.from(json["majors"]!.map((x) => Major.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "courses": courses == null ? [] : List<dynamic>.from(courses!.map((x) => x.toJson())),
        "majors": majors == null ? [] : List<dynamic>.from(majors!.map((x) => x.toJson())),
    };
}

class Course {
    int? id;
    String? name;
    String? description;
    String? image;
    int? price;
    int? discountPrice;
    int? collegeId;
    String? college;
    int? majorId;
    String? major;
    int? professorId;
    String? professor;

    Course({
        this.id,
        this.name,
        this.description,
        this.image,
        this.price,
        this.discountPrice,
        this.collegeId,
        this.college,
        this.majorId,
        this.major,
        this.professorId,
        this.professor,
    });

    factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        price: json["price"],
        discountPrice: json["discount_price"],
        collegeId: json["college_id"],
        college: json["college"],
        majorId: json["major_id"],
        major: json["major"],
        professorId: json["professor_id"],
        professor: json["professor"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "price": price,
        "discount_price": discountPrice,
        "college_id": collegeId,
        "college": college,
        "major_id": majorId,
        "major": major,
        "professor_id": professorId,
        "professor": professor,
    };
}

class Major {
    int? id;
    String? name;

    Major({
        this.id,
        this.name,
    });

    factory Major.fromJson(Map<String, dynamic> json) => Major(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
