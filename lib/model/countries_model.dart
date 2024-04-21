class CountryModel {
  String? code;
  String? nameAR;
  String? nameEN;
  String? dialCode;

  CountryModel({
    this.code,
    this.nameAR,
    this.nameEN,
    this.dialCode,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        code: json["code"],
        nameAR: json["name_ar"],
        nameEN: json["name_en"],
        dialCode: json["dialCode"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name_ar": nameAR,
        "name_en": nameEN,
        "dialCode": dialCode,
      };
}
