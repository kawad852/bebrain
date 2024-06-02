class FilterModel {
  String? wizardType;
  int? countryId;
  String? countryName;
  String? countryCode;
  int? universityId;
  String? universityName;
  int? collegeId;
  String? collegeName;
  int? majorId;
  String? majorName;

  FilterModel({
    this.wizardType,
    this.countryId,
    this.countryName,
    this.countryCode,
    this.universityId,
    this.universityName,
    this.collegeId,
    this.collegeName,
    this.majorId,
    this.majorName,
  });

  factory FilterModel.copy(FilterModel filterModel) =>FilterModel.fromJson(filterModel.toJson());

  factory FilterModel.fromJson(Map<String, dynamic> json) => FilterModel(
        wizardType: json["wizardType"],
        countryId: json["countryId"],
        countryName: json["countryName"],
        countryCode:json["countryCode"],
        universityId: json["universityId"],
        universityName: json["universityName"],
        collegeId: json["collegeId"],
        collegeName: json["collegeName"],
        majorId: json["majorId"],
        majorName: json["majorName"],
      );

  Map<String, dynamic> toJson() => {
        "wizardType": wizardType.toString(),
        "countryId": countryId,
        "countryCode":countryCode,
        "countryName": countryName,
        "universityId": universityId,
        "universityName": universityName,
        "collegeId": collegeId,
        "collegeName": collegeName,
        "majorId": majorId,
        "majorName": majorName,
      };
}
