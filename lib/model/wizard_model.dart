class WizardModel {
  bool? status;
  int? code;
  String? msg;
  List<WizardData>? data;

  WizardModel({
    this.status,
    this.code,
    this.msg,
    this.data,
  });

  factory WizardModel.fromJson(Map<String, dynamic> json) => WizardModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? [] : List<WizardData>.from(json["data"]!.map((x) => WizardData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class WizardData {
  int? id;
  String? name;
  int? countryId;
  String? country;
  String? flag;

  WizardData({
    this.id,
    this.name,
    this.countryId,
    this.country,
    this.flag,
  });

  factory WizardData.fromJson(Map<String, dynamic> json) => WizardData(
        id: json["id"],
        name: json["name"],
        countryId: json["country_id"],
        country: json["country"],
        flag: json["flag"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_id": countryId,
        "country": country,
        "flag": flag,
      };
}
