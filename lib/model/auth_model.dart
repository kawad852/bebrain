class AuthModel {
  bool? status;
  String? msg;
  Data? data;

  AuthModel({
    this.status,
    this.msg,
    this.data,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        status: json["status"],
        msg: json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
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
  String? profileImg;
  String? invitationCode;
  int? points;
  String? deviceToken;
  int? invitationCodeStatus;
  List<Favorite>? favorites;

  UserData({
    this.id,
    this.name,
    this.email,
    this.invitationCode,
    this.points,
    this.deviceToken,
    this.invitationCodeStatus,
    this.favorites,
    this.profileImg,
  });

  factory UserData.copy(UserData userModel) => UserData.fromJson(userModel.toJson());

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        name: json["name"] ?? '',
        email: json["email"],
        profileImg: json["profile_img"] ?? '',
        invitationCode: json["invitation_code"],
        points: json["points"],
        deviceToken: json["device_token"],
        invitationCodeStatus: json["invitation_code_status"],
        favorites: json["favorites"] == null
            ? []
            : List<Favorite>.from(json["favorites"]!.map((x) => Favorite.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "profile_img": profileImg,
        "email": email,
        "invitation_code": invitationCode,
        "points": points,
        "device_token": deviceToken,
        "invitation_code_status":invitationCodeStatus,
        "favorites": favorites == null ? [] : List<dynamic>.from(favorites!.map((x) => x.toJson())),
      };
}

class Favorite {
  int? id;
  int? userId;
  String? type;
  String? favoritableId;
  int? isFavorite;

  Favorite({
    this.id,
    this.userId,
    this.type,
    this.favoritableId,
    this.isFavorite,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
        id: json["id"],
        userId: json["user_id"],
        type: json["type"],
        favoritableId: json["favoritable_id"],
        isFavorite: json["is_favorite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "type": type,
        "favoritable_id": favoritableId,
        "is_favorite": isFavorite,
      };
}
