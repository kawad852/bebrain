class GeneralModel {
  int? status;
  String? message;

  GeneralModel({
    this.status,
    this.message,
  });

  factory GeneralModel.fromJson(Map<String, dynamic> json) => GeneralModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
