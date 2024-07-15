class FormEnum {
  static const String project = "project";
  static const String assignment = "assignment";
  static const String studyExplanation = "study_explanation";
}

class WizardType {
  static const String countries = 'countries';
  static const String universities = 'universities';
  static const String colleges = 'colleges';
  static const String specialities = 'specialities';
}

class RequestType{
  static const String pending = 'pending';
  static const String pendingPayment = 'pending_payment';
  static const String canceled = 'canceled';
  static const String inProgress = 'in_progress';
  static const String done = 'done';
  static const String interviewAdded = 'interview_added';
  static const String rejected = 'rejected';
}

class SubscriptionsType{
  static const String course = 'course';
  static const String unit  = 'unit';
  static const String section = 'section';
}

class PaymentStatus{
  static const int paid = 1;
  static const int unPaid = 0;
}

class PaymentType{
  static const String free = "free";
  static const String notFree = "paid";
}

class LanguageEnum {
  static const String english = 'en';
  static const String arabic = 'ar';
}

class OrderType{
  static const String subscription = "subscription";
  static const String request = "request";
  static const String interview = "interview";
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
