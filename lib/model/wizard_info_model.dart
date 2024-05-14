import 'package:bebrain/utils/enums.dart';

class WizardInfoModel {
  String? apiUrl;
  String? headerTitle;
  String? headerBody;
  String? hintText;
  WizardType? nextType;

  WizardInfoModel({
    this.apiUrl,
    this.headerTitle,
    this.headerBody,
    this.hintText,
    this.nextType,
  });
}
