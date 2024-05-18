class ProfessorsModel {
    bool? status;
    int? code;
    String? msg;
    List<ProfessorData>? data;

    ProfessorsModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory ProfessorsModel.fromJson(Map<String, dynamic> json) => ProfessorsModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<ProfessorData>.from(json["data"]!.map((x) => ProfessorData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class ProfessorData {
    int? id;
    String? name;
    String? description;
    String? image;
    int? universityId;
    String? universityName;
    List<Major>? majors;
    List<College>? colleges;

    ProfessorData({
        this.id,
        this.name,
        this.description,
        this.image,
        this.universityId,
        this.universityName,
        this.majors,
        this.colleges,
    });

    factory ProfessorData.fromJson(Map<String, dynamic> json) => ProfessorData(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        universityId: json["university_id"],
        universityName: json["university_name"],
        majors: json["majors"] == null ? [] : List<Major>.from(json["majors"]!.map((x) => Major.fromJson(x))),
        colleges: json["colleges"] == null ? [] : List<College>.from(json["colleges"]!.map((x) => College.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "university_id": universityId,
        "university_name": universityName,
        "majors": majors == null ? [] : List<dynamic>.from(majors!.map((x) => x.toJson())),
        "colleges": colleges == null ? [] : List<dynamic>.from(colleges!.map((x) => x.toJson())),
    };
}

class College {
    int? id;
    String? name;
    int? universityId;
    String? university;

    College({
        this.id,
        this.name,
        this.universityId,
        this.university,
    });

    factory College.fromJson(Map<String, dynamic> json) => College(
        id: json["id"],
        name: json["name"],
        universityId: json["university_id"],
        university: json["university"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "university_id": universityId,
        "university": university,
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
