import 'package:bebrain/model/country_filter_model.dart' as co;
import 'package:bebrain/model/subscriptions_model.dart';

class CourseFilterModel {
    bool? status;
    int? code;
    String? msg;
    CourseFilterData? data;

    CourseFilterModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory CourseFilterModel.fromJson(Map<String, dynamic> json) => CourseFilterModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? null : CourseFilterData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data?.toJson(),
    };
}

class CourseFilterData {
    Course? course;
    List<co.Course>? moreCourses;

    CourseFilterData({
        this.course,
        this.moreCourses,
    });

    factory CourseFilterData.fromJson(Map<String, dynamic> json) => CourseFilterData(
        course: json["course"] == null ? null : Course.fromJson(json["course"]),
        moreCourses: json["more_courses"] == null ? [] : List<co.Course>.from(json["more_courses"]!.map((x) => co.Course.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "course": course?.toJson(),
        "more_courses": moreCourses == null ? [] : List<dynamic>.from(moreCourses!.map((x) => x.toJson())),
    };
}

class Course {
    int? id;
    String? name;
    String? description;
    String? image;
    double? price;
    double? discountPrice;
    int? universityId;
    String? university;
    int? collegeId;
    String? college;
    int? majorId;
    String? major;
    int? videosCount;
    int? unitsCount;
    int? hours;
    int? minutes;
    int? autoPlay;
    int? subscriptionCount;
    int? available;
    double? reviewsRating;
    int? reviewsCount;
    double? audioVideoQuality;
    double? valueForMoney;
    double? conveyIdea;
    double? similarityCurriculumContent;
    int? paymentStatus;
    int? isSubscribed;
    String? productId;
    String? freeVimeoId;
    int? freeVideoId;
    List<SubscriptionsData>? subscription;
    co.Professor? professor;
    Offer? offer;
    List<Unit>? units;
    List<Exam>? exams;

    Course({
        this.id,
        this.name,
        this.description,
        this.image,
        this.price,
        this.discountPrice,
        this.universityId,
        this.university,
        this.collegeId,
        this.college,
        this.majorId,
        this.major,
        this.videosCount,
        this.unitsCount,
        this.hours,
        this.minutes,
        this.autoPlay,
        this.subscriptionCount,
        this.available,
        this.reviewsRating,
        this.reviewsCount,
        this.audioVideoQuality,
        this.valueForMoney,
        this.conveyIdea,
        this.similarityCurriculumContent,
        this.paymentStatus,
        this.isSubscribed,
        this.productId,
        this.freeVimeoId,
        this.freeVideoId,
        this.subscription,
        this.professor,
        this.offer,
        this.units,
        this.exams,
    });

    factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        price: json["price"]?.toDouble(),
        discountPrice: json["discount_price"]?.toDouble(),
        universityId: json["university_id"],
        university: json["university"],
        collegeId: json["college_id"],
        college: json["college"],
        majorId: json["major_id"],
        major: json["major"],
        videosCount: json["videos_count"],
        unitsCount: json["units_count"],
        hours: json["hours"],
        minutes: json["minutes"],
        autoPlay: json['auto_play'],
        subscriptionCount: json["subscription_count"],
        available: json["available"],
        reviewsRating: json["reviews_rating"]?.toDouble(),
        reviewsCount: json["reviews_count"],
        audioVideoQuality: json["audio_video_quality"]?.toDouble(),
        valueForMoney: json["value_for_money"]?.toDouble(),
        conveyIdea: json["convey_idea"]?.toDouble(),
        similarityCurriculumContent: json["similarity_curriculum_content"]?.toDouble(),
        paymentStatus: json["payment_status"],
        isSubscribed: json["is_subscribed"],
        productId: json["product_id"],
        freeVimeoId: json["free_vimeo_id"],
        freeVideoId: json["free_video_id"],
        subscription: json["subscription"] == null ? [] : List<SubscriptionsData>.from(json["subscription"]!.map((x) => SubscriptionsData.fromJson(x))),
        professor: json["professor"] == null ? null : co.Professor.fromJson(json["professor"]),
        offer: json["offer"] == null ? null : Offer.fromJson(json["offer"]),
        units: json["units"] == null ? [] : List<Unit>.from(json["units"]!.map((x) => Unit.fromJson(x))),
        exams: json["exams"] == null ? [] : List<Exam>.from(json["exams"]!.map((x) => Exam.fromJson(x))),

    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "price": price,
        "discount_price": discountPrice,
        "university_id": universityId,
        "university": university,
        "college_id": collegeId,
        "college": college,
        "major_id": majorId,
        "major": major,
        "videos_count": videosCount,
        "units_count": unitsCount,
        "hours": hours,
        "minutes": minutes,
        "auto_play": autoPlay,
        "subscription_count": subscriptionCount,
        "available": available,
        "reviews_rating": reviewsRating,
        "reviews_count": reviewsCount,
        "audio_video_quality": audioVideoQuality,
        "value_for_money": valueForMoney,
        "convey_idea": conveyIdea,
        "similarity_curriculum_content": similarityCurriculumContent,
        "payment_status": paymentStatus,
        "is_subscribed": isSubscribed,
        "product_id": productId,
        "free_vimeo_id": freeVimeoId,
        "free_video_id": freeVideoId,
        "subscription": subscription == null ? [] : List<dynamic>.from(subscription!.map((x) => x.toJson())),
        "professor": professor?.toJson(),
        "offer": offer?.toJson(),
        "units": units == null ? [] : List<dynamic>.from(units!.map((x) => x.toJson())),
        "exams": exams == null ? [] : List<dynamic>.from(exams!.map((x) => x.toJson())),
    };
}

class Exam {
    int? id;
    String? name;
    int? paymentType;
    String? link;
    int? periodInMinutes;
    List<dynamic>? links;

    Exam({
        this.id,
        this.name,
        this.paymentType,
        this.link,
        this.periodInMinutes,
        this.links,
    });

    factory Exam.fromJson(Map<String, dynamic> json) => Exam(
        id: json["id"],
        name: json["name"],
        paymentType: json["payment_type"],
        link: json["link"],
        periodInMinutes: json["period_in_minutes"],
        links: json["links"] == null ? [] : List<dynamic>.from(json["links"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "payment_type": paymentType,
        "link": link,
        "period_in_minutes": periodInMinutes,
        "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x)),
    };
}


class Offer {
    int? id;
    String? content;
    DateTime? startDate;
    DateTime? endDate;

    Offer({
        this.id,
        this.content,
        this.startDate,
        this.endDate,
    });

    factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["id"],
        content: json["content"],
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
    };
}

class Unit {
    int? id;
    String? name;
    int? tag;
    int? order;
    double? unitPrice;
    double? discountPrice;
    int? courseId;
    int? videosCount;
    int? documentsCount;
    int? videosMinutes;
    String? type;
    int? paymentStatus;
    int? examsCount;
    int? subscriptionCount;
    List<SubscriptionsData>? subscription;
    Offer? offer;
    List<Exam>? exams;

    Unit({
        this.id,
        this.name,
        this.tag,
        this.order,
        this.unitPrice,
        this.discountPrice,
        this.courseId,
        this.videosCount,
        this.documentsCount,
        this.videosMinutes,
        this.type,
        this.paymentStatus,
        this.examsCount,
        this.subscriptionCount,
        this.subscription,
        this.offer,
        this.exams,
    });

    factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        id: json["id"],
        name: json["name"],
        tag: json["tag"],
        order: json["order"],
        unitPrice: json["unit_price"]?.toDouble(),
        discountPrice: json["discount_price"]?.toDouble(),
        courseId: json["course_id"],
        videosCount: json["videos_count"],
        documentsCount: json["documents_count"],
        videosMinutes: json["videos_minutes"],
        type: json["type"],
        paymentStatus: json["payment_status"],
        examsCount: json["exams_count"],
        subscriptionCount: json["subscription_count"],
        subscription: json["subscription"] == null ? [] : List<SubscriptionsData>.from(json["subscription"]!.map((x) => SubscriptionsData.fromJson(x))),
        offer: json["offer"] == null ? null : Offer.fromJson(json["offer"]),
        exams: json["exams"] == null ? [] : List<Exam>.from(json["exams"]!.map((x) => Exam.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "tag": tag,
        "order": order,
        "unit_price": unitPrice,
        "discount_price": discountPrice,
        "course_id": courseId,
        "videos_count": videosCount,
        "documents_count": documentsCount,
        "videos_minutes": videosMinutes,
        "type":type,
        "payment_status":paymentStatus,
        "exams_count": examsCount,
        "subscription_count": subscriptionCount,
        "subscription": subscription == null ? [] : List<dynamic>.from(subscription!.map((x) => x.toJson())),
        "offer": offer?.toJson(),
        "exams": exams == null ? [] : List<dynamic>.from(exams!.map((x) => x.toJson())),
    };
}
