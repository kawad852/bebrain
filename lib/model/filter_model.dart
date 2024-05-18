class FilterModel {
  String? wizardType;
  int? countryId;
  String? countryName;
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
    this.universityId,
    this.universityName,
    this.collegeId,
    this.collegeName,
    this.majorId,
    this.majorName,
  });

  factory FilterModel.copy(FilterModel userModel) =>FilterModel.fromJson(userModel.toJson());

  factory FilterModel.fromJson(Map<String, dynamic> json) => FilterModel(
        wizardType: json["wizardType"],
        countryId: json["countryId"],
        countryName: json["countryName"],
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
        "countryName": countryName,
        "universityId": universityId,
        "universityName": universityName,
        "collegeId": collegeId,
        "collegeName": collegeName,
        "majorId": majorId,
        "majorName": majorName,
      };
}
