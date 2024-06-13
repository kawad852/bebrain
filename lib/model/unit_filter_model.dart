import 'package:bebrain/model/course_filter_model.dart';

class UnitFilterModel {
    bool? status;
    int? code;
    String? msg;
    UnitFilterData? data;

    UnitFilterModel({
        this.status,
        this.code,
        this.msg,
        this.data,
    });

    factory UnitFilterModel.fromJson(Map<String, dynamic> json) => UnitFilterModel(
        status: json["status"],
        code: json["code"],
        msg: json["msg"],
        data: json["data"] == null ? null : UnitFilterData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "msg": msg,
        "data": data?.toJson(),
    };
}

class UnitFilterData {
    int? id;
    String? name;
    int? tag;
    int? order;
    double? unitPrice;
    double? discountPrice;
    int? courseId;
    String? courseName;
    int? videosCount;
    int? documentsCount;
    int? videosMinutes;
    Offer? offer;
    List<Section>? sections;

    UnitFilterData({
        this.id,
        this.name,
        this.tag,
        this.order,
        this.unitPrice,
        this.discountPrice,
        this.courseId,
        this.courseName,
        this.videosCount,
        this.documentsCount,
        this.videosMinutes,
        this.offer,
        this.sections,
    });

    factory UnitFilterData.fromJson(Map<String, dynamic> json) => UnitFilterData(
        id: json["id"],
        name: json["name"],
        tag: json["tag"],
        order: json["order"],
        unitPrice: json["unit_price"]?.toDouble(),
        discountPrice: json["discount_price"]?.toDouble(),
        courseId: json["course_id"],
        courseName: json["course_name"],
        videosCount: json["videos_count"],
        documentsCount: json["documents_count"],
        videosMinutes: json["videos_minutes"],
        offer: json["offer"] == null ? null : Offer.fromJson(json["offer"]),
        sections: json["sections"] == null ? [] : List<Section>.from(json["sections"]!.map((x) => Section.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "tag": tag,
        "order": order,
        "unit_price": unitPrice,
        "discount_price": discountPrice,
        "course_id": courseId,
        "course_name":courseName,
        "videos_count": videosCount,
        "documents_count": documentsCount,
        "videos_minutes": videosMinutes,
        "offer": offer?.toJson(),
        "sections": sections == null ? [] : List<dynamic>.from(sections!.map((x) => x.toJson())),
    };
}

class Section {
    int? id;
    String? name;
    int? tag;
    int? order;
    int? courseId;
    String? courseName;
    double? sectionPrice;
    double? discountPrice;
    int? videosCount;
    int? documentsCount;
    int? numberOfMinutes;
    Offer? offer;
    List<Video>? videos;
    List<Document>? documents;

    Section({
        this.id,
        this.name,
        this.tag,
        this.order,
        this.courseId,
        this.courseName,
        this.sectionPrice,
        this.discountPrice,
        this.videosCount,
        this.documentsCount,
        this.numberOfMinutes,
        this.offer,
        this.videos,
        this.documents,
    });

    factory Section.fromJson(Map<String, dynamic> json) => Section(
        id: json["id"],
        name: json["name"],
        tag: json["tag"],
        order: json["order"],
        courseId: json["course_id"],
        courseName: json["course_name"],
        sectionPrice: json["section_price"]?.toDouble(),
        discountPrice: json["discount_price"]?.toDouble(),
        videosCount: json["videos_count"],
        documentsCount: json["documents_count"],
        numberOfMinutes: json["number_of_minutes"],
        offer: json["offer"] == null ? null : Offer.fromJson(json["offer"]),
        videos: json["videos"] == null ? [] : List<Video>.from(json["videos"]!.map((x) => Video.fromJson(x))),
        documents: json["documents"] == null ? [] : List<Document>.from(json["documents"]!.map((x) => Document.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "tag": tag,
        "order": order,
        "course_id": courseId,
        "course_name": courseName,
        "section_price": sectionPrice,
        "discount_price": discountPrice,
        "videos_count": videosCount,
        "documents_count": documentsCount,
        "number_of_minutes": numberOfMinutes,
        "offer": offer?.toJson(),
        "videos": videos == null ? [] : List<dynamic>.from(videos!.map((x) => x.toJson())),
        "documents": documents == null ? [] : List<dynamic>.from(documents!.map((x) => x.toJson())),
    };
}

class Document {
    int? id;
    String? name;
    String? document;
    int? paymentStatus;

    Document({
        this.id,
        this.name,
        this.document,
        this.paymentStatus,
    });

    factory Document.fromJson(Map<String, dynamic> json) => Document(
        id: json["id"],
        name: json["name"],
        document: json["document"],
        paymentStatus: json["payment_status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "document": document,
        "payment_status": paymentStatus,
    };
}

class Video {
    int? id;
    String? name;
    String? vimeoId;
    int? courseId;
    String? course;
    int? unitId;
    String? unit;
    int? sectionId;
    String? section;
    int? period;
    int? paymentStatus;
    dynamic document;

    Video({
        this.id,
        this.name,
        this.vimeoId,
        this.courseId,
        this.course,
        this.unitId,
        this.unit,
        this.sectionId,
        this.section,
        this.period,
        this.paymentStatus,
        this.document,
    });

    factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        name: json["name"],
        vimeoId: json["vimeo_id"],
        courseId: json["course_id"],
        course: json["course"],
        unitId: json["unit_id"],
        unit: json["unit"],
        sectionId: json["section_id"],
        section: json["section"],
        period: json["period"],
        paymentStatus: json["payment_status"],
        document: json["document"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "vimeo_id": vimeoId,
        "course_id": courseId,
        "course": course,
        "unit_id": unitId,
        "unit": unit,
        "section_id": sectionId,
        "section": section,
        "period": period,
        "payment_status": paymentStatus,
        "document": document,
    };
}
