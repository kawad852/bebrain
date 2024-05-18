enum FormEnum { duties, specialExplanation, graduationProjects }

// enum WizardType {
//   countries,
//   universities,
//   colleges,
//   specialities,
// }

class WizardType{
  static const String countries='countries';
  static const String universities='universities';
  static const String colleges='colleges';
  static const String specialities='specialities';
}
class LanguageEnum {
  static const String english = 'en';
  static const String arabic = 'ar';
}

class ThemeEnum {
  static const String light = 'light';
  static const String dark = 'dark';
}

class LikeType {
  static const int like = 1;
  static const int disLike = 0;
}

class CompoTypeEnum {
  static const String teams = '1';
  static const String competitions = '2';
  static const String blogs = '3';
}

class NotificationsType {
  static const String blog = 'blog';
  static const String match = 'match';
  static const String live = 'live';
  static const String url = 'url';
}

class BlogsType {
  static String recommended = 'user';
  static String teams(int id) => 'teams/$id';
  static String competitions(int id) => 'competitions/$id';
  static String tag(int id) => 'competitions/$id';
}

class EmailJsEnum {
  static const link = 'https://api.emailjs.com/api/v1.0/email/send';
  static const serviceId = "service_85zuv8l"; // service_dga8ga8
  static const templateId = "template_4w6bflf"; //template_kibj8m3
  static const userId = "QIWycTMidTmWWH1ro"; //kdJ4pcQ38XFqx54Lk
}
