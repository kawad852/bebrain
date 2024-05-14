class CountryCodeModel {
  String? ip;
  String? country;
  String? countryCode;

  CountryCodeModel({
    this.ip,
    this.country,
    this.countryCode,
  });

  factory CountryCodeModel.fromJson(Map<String, dynamic> json) => CountryCodeModel(
        ip: json["ip"],
        country: json["country"],
        countryCode: json["countryCode"],
      );

  Map<String, dynamic> toJson() => {
        "ip": ip,
        "country": country,
        "countryCode": countryCode,
      };
}
