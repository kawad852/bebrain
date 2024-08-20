class AuthModel {
  bool? status;
  int? code;
  String? msg;
  Data? data;

  AuthModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data?.toJson(),
      };
}

class Data {
  String? token;
  UserData? user;

  Data({
    this.token,
    this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        user: json["user"] == null ? null : UserData.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user?.toJson(),
      };
}

class UserData {
    int? id;
    String? name;
    String? email;
    String? phoneNumber;
    String? image;
    String? accountNumber;
    String? code;
    String? deviceToken;
    int? status;
    String? locale;
    int? countryId;
    String? country;
    String? countryCode;
    int? universityId;
    String? universityName;
    int? collegeId;
    String? collegeName;
    int? majorId;
    String? majorName;
    int? numberOfCourses;
    int? videosCount;
    int? hours;
    int? minutes;

    UserData({
        this.id,
        this.name,
        this.email,
        this.phoneNumber,
        this.image,
        this.accountNumber,
        this.code,
        this.deviceToken,
        this.status,
        this.locale,
        this.countryId,
        this.country,
        this.countryCode,
        this.universityId,
        this.universityName,
        this.collegeId,
        this.collegeName,
        this.majorId,
        this.majorName,
        this.numberOfCourses,
        this.videosCount,
        this.hours,
        this.minutes,
    });

    factory UserData.copy(UserData userModel) => UserData.fromJson(userModel.toJson());

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        name: json["name"] ??'',
        email: json["email"],
        phoneNumber: json["phone_number"],
        image: json["image"] ??'',
        accountNumber: json["account_number"],
        code: json["code"],
        deviceToken: json["device_token"],
        status: json["status"],
        locale: json["locale"],
        countryId: json["country_id"],
        country: json["country"],
        countryCode: json["country_code"],
        universityId: json["university_id"],
        universityName: json["university_name"],
        collegeId: json["college_id"],
        collegeName: json["college_name"],
        majorId: json["major_id"],
        majorName: json["major_name"],
        numberOfCourses: json["number_of_courses"],
        videosCount: json["videos_count"],
        hours: json["hours"],
        minutes: json["minutes"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "image": image,
        "account_number": accountNumber,
        "code": code,
        "device_token": deviceToken,
        "status": status,
        "locale": locale,
        "country_id": countryId,
        "country": country,
        "country_code":countryCode,
        "university_id": universityId,
        "university_name": universityName,
        "college_id": collegeId,
        "college_name": collegeName,
        "major_id": majorId,
        "major_name": majorName,
        "number_of_courses": numberOfCourses,
        "videos_count": videosCount,
        "hours": hours,
        "minutes": minutes,
    };
}


