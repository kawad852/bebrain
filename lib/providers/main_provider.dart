import 'dart:io';

import 'package:bebrain/model/college_filter_model.dart';
import 'package:bebrain/model/continue_learning_model.dart';
import 'package:bebrain/model/country_filter_model.dart';
import 'package:bebrain/model/course_filter_model.dart';
import 'package:bebrain/model/course_rating_model.dart';
import 'package:bebrain/model/course_review_model.dart';
import 'package:bebrain/model/interview_model.dart';
import 'package:bebrain/model/major_filter_model.dart';
import 'package:bebrain/model/new_request_model.dart';
import 'package:bebrain/model/order_model.dart';
import 'package:bebrain/model/policy_model.dart';
import 'package:bebrain/model/professors_model.dart';
import 'package:bebrain/model/projects_model.dart';
import 'package:bebrain/model/single_interview_model.dart';
import 'package:bebrain/model/slider_model.dart';
import 'package:bebrain/model/subscriptions_model.dart';
import 'package:bebrain/model/teacher_evalution_model.dart';
import 'package:bebrain/model/teacher_model.dart';
import 'package:bebrain/model/teacher_review_model.dart';
import 'package:bebrain/model/unit_filter_model.dart';
import 'package:bebrain/model/university_filter_model.dart';
import 'package:bebrain/model/user_subscription_model.dart';
import 'package:bebrain/model/video_view_model.dart';
import 'package:bebrain/model/wizard_model.dart';
import 'package:bebrain/network/api_service.dart';
import 'package:bebrain/network/api_url.dart';
import 'package:bebrain/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MainProvider extends ChangeNotifier {
  Future<CountryFilterModel> filterByCountry(int countryId) {
    final snapshot = ApiService<CountryFilterModel>().build(
      url: "${ApiUrl.countryFilter}/$countryId",
      isPublic: true,
      apiType: ApiType.get,
      builder: CountryFilterModel.fromJson,
    );
    return snapshot;
  }

  Future<UniversityFilterModel> filterByUniversity(int universityId) {
    final snapshot = ApiService<UniversityFilterModel>().build(
      url: "${ApiUrl.universityFilter}/$universityId",
      isPublic: true,
      apiType: ApiType.get,
      builder: UniversityFilterModel.fromJson,
    );
    return snapshot;
  }

  Future<CollegeFilterModel> filterByCollege(int collegeId) {
    final snapshot = ApiService<CollegeFilterModel>().build(
      url: "${ApiUrl.collegeFilter}/$collegeId",
      isPublic: true,
      apiType: ApiType.get,
      builder: CollegeFilterModel.fromJson,
    );
    return snapshot;
  }

  Future<ProfessorsModel> fetchProfessors(int pageKey) {
    final snapshot = ApiService<ProfessorsModel>().build(
      url: "${ApiUrl.professors}?page=$pageKey",
      isPublic: true,
      apiType: ApiType.get,
      builder: ProfessorsModel.fromJson,
    );
    return snapshot;
  }

  Future<MajorFilterModel> filterByMajor({
    required int collegeId,
    required int majorId,
  }) {
    final snapshot = ApiService<MajorFilterModel>().build(
      url: "${ApiUrl.majorFilter}/$collegeId/$majorId",
      isPublic: true,
      apiType: ApiType.get,
      builder: MajorFilterModel.fromJson,
    );
    return snapshot;
  }

  Future<CourseFilterModel> filterByCourse(int courseId) {
    final snapshot = ApiService<CourseFilterModel>().build(
      url: "${ApiUrl.courseFilter}/$courseId",
      isPublic: false,
      apiType: ApiType.get,
      builder: CourseFilterModel.fromJson,
    );
    return snapshot;
  }

  Future<UnitFilterModel> filterByUnit(int unitId) {
    final snapshot = ApiService<UnitFilterModel>().build(
      url: "${ApiUrl.unitFilter}/$unitId",
      isPublic: false,
      apiType: ApiType.get,
      builder: UnitFilterModel.fromJson,
    );
    return snapshot;
  }

  Future<PolicyModel> fetchPages(int page) {
    final snapshot = ApiService<PolicyModel>().build(
      url: "${ApiUrl.policy}/$page",
      isPublic: true,
      apiType: ApiType.get,
      builder: PolicyModel.fromJson,
    );
    return snapshot;
  }

  Future<WizardModel> fetchCUCM(String url) {
    final snapshot = ApiService<WizardModel>().build(
      url: url,
      isPublic: true,
      apiType: ApiType.get,
      builder: WizardModel.fromJson,
    );
    return snapshot;
  }

  Future<NewRequestModel> createRequest({
    required String type,
    required int countryId,
    required int universityId,
    required int collegeId,
    required int majorId,
    required String title,
    String? note,
    required List<File> attachments,
  }) {
    final snapshot = ApiService<NewRequestModel>().uploadFiles(
     url: ApiUrl.newRequest,
     builder: NewRequestModel.fromJson,
     onRequest: (request) async{
      request.headers['Authorization'] = 'Bearer ${MySharedPreferences.accessToken}';
      request.headers['Content-Type'] = 'application/json';
      request.headers['x-localization'] = MySharedPreferences.language;
      request.fields['type'] = type;
      request.fields['country_id'] = countryId.toString();
      request.fields['university_id'] = universityId.toString();
      request.fields['college_id'] = collegeId.toString();
      request.fields['major_id'] = majorId.toString();
      request.fields['title'] = title;
      if(note!=null) request.fields['note'] = note;
      for(var i=0; i<=attachments.length;i++){
        var file=attachments[i];
        var stream= http.ByteStream(file.openRead());
        var length = await file.length();
        var multipartFile = http.MultipartFile('attachments[$i]', stream, length, filename: file.path.split('/').last);
        request.files.add(multipartFile);
      }
     }
    ); 
    return snapshot;
  }

  Future<NewRequestModel> fetchRequest(int requestId) {
    final snapshot = ApiService<NewRequestModel>().build(
      url: "${ApiUrl.newRequest}/$requestId",
      isPublic: false,
      apiType: ApiType.get,
      builder: NewRequestModel.fromJson,
    );
    return snapshot;
  }

  Future<ProjectsModel> fetchMyRequest(String url) {
    final snapshot = ApiService<ProjectsModel>().build(
      url: "${ApiUrl.newRequest}/$url",
      isPublic: false,
      apiType: ApiType.get,
      builder: ProjectsModel.fromJson,
    );
    return snapshot;
  }

  Future<SubscriptionsModel> subscribe({
    required String type,
    required int id,
  }) {
    final snapshot = ApiService<SubscriptionsModel>().build(
      url: ApiUrl.subscriptions,
      isPublic: false,
      apiType: ApiType.post,
      queryParams: {
        "type": type,
        "subscriable_id": id,
      },
      builder: SubscriptionsModel.fromJson,
    );
    return snapshot;
  }

  Future<VideoViewModel> videoView(int videoId) {
    final snapshot = ApiService<VideoViewModel>().build(
      url: ApiUrl.videoView,
      isPublic: false,
      apiType: ApiType.post,
      queryParams: {
        "video_id": videoId,
      },
      builder: VideoViewModel.fromJson,
    );
    return snapshot;
  }

  Future<ContinueLearningModel> fetchMyLearning() {
    final snapshot = ApiService<ContinueLearningModel>().build(
      url: ApiUrl.continueLearning,
      isPublic: false,
      apiType: ApiType.get,
      builder: ContinueLearningModel.fromJson,
    );
    return snapshot;
  }

  Future<CourseRatingModel> rateCourse({
    required int courseId,
    required String comment,
    required double audioVideoQuality,
    required double valueForMoney,
    required double conveyIdea,
    required double similarityCurriculumContent
  }) {
    final snapshot = ApiService<CourseRatingModel>().build(
      url: ApiUrl.courseRating,
      isPublic: false,
      apiType: ApiType.post,
      queryParams: {
        "comment": comment,
        "course_id": courseId,
        "audio_video_quality": audioVideoQuality,
        "value_for_money": valueForMoney,
        "convey_idea": conveyIdea,
        "similarity_curriculum_content": similarityCurriculumContent,
      },
      builder: CourseRatingModel.fromJson,
    );
    return snapshot;
  }

  Future<TeacherReviewModel> rateProfessor({
    required int professorId,
    required double rating,
    required String comment,
  }) {
    final snapshot = ApiService<TeacherReviewModel>().build(
      url: ApiUrl.professorRating,
      isPublic: false,
      apiType: ApiType.post,
      queryParams: {
        "comment": comment,
        "professor_id": professorId,
        "rating": rating,
      },
      builder: TeacherReviewModel.fromJson,
    );
    return snapshot;
  }

  Future<TeacherModel> fetchProfessorById(int id) {
    final snapshot = ApiService<TeacherModel>().build(
      url: "${ApiUrl.professors}/$id",
      isPublic: true,
      apiType: ApiType.get,
      builder: TeacherModel.fromJson,
    );
    return snapshot;
  }

  Future<TeacherEvalutionModel> fetchProfessorReviews({
    required int pageKey,
    required int professorId,
    }) {
    final snapshot = ApiService<TeacherEvalutionModel>().build(
      url: "${ApiUrl.professorAllRating}/$professorId?page=$pageKey",
      isPublic: true,
      apiType: ApiType.get,
      builder: TeacherEvalutionModel.fromJson,
    );
    return snapshot;
  }

  Future<OrderModel> createOrder({
    required String type,
    required int orderableId,
    required double amount,
    }) {
    final snapshot = ApiService<OrderModel>().build(
      url: ApiUrl.orders,
      isPublic: false,
      apiType: ApiType.post,
      queryParams: {
        "type": type,
        "orderable_id": orderableId,
        "amount": amount,
      },
      builder: OrderModel.fromJson,
    );
    return snapshot;
  }

  Future<CourseReviewModel> fetchCourseReviews({
    required int pageKey,
    required int courseId,
    }) {
    final snapshot = ApiService<CourseReviewModel>().build(
      url: "${ApiUrl.courseReview}/$courseId?page=$pageKey",
      isPublic: true,
      apiType: ApiType.get,
      builder: CourseReviewModel.fromJson,
    );
    return snapshot;
  }

   Future<UserSubscriptionModel> fetchMySubscription() {
    final snapshot = ApiService<UserSubscriptionModel>().build(
      url: ApiUrl.userSubscription,
      isPublic: false,
      apiType: ApiType.get,
      builder: UserSubscriptionModel.fromJson,
    );
    return snapshot;
  }

  Future<ProfessorsModel> searchProfessors(int pageKey, String value) {
    final snapshot = ApiService<ProfessorsModel>().build(
      url: "${ApiUrl.professorsSearch}?page=$pageKey",
      isPublic: true,
      apiType: ApiType.post,
      queryParams: {
        "search": value,
      },
      builder: ProfessorsModel.fromJson,
    );
    return snapshot;
  }

   Future<SliderModel> fetchMySlider(int countryId) {
    final snapshot = ApiService<SliderModel>().build(
      url: "${ApiUrl.slider}/$countryId",
      isPublic: true,
      apiType: ApiType.get,
      builder: SliderModel.fromJson,
    );
    return snapshot;
  }

  Future<InterviewModel> fetchMyInterViews() {
    final snapshot = ApiService<InterviewModel>().build(
      url: ApiUrl.myInterviews,
      isPublic: false,
      apiType: ApiType.get,
      builder: InterviewModel.fromJson,
    );
    return snapshot;
  }

  Future<SingleInterviewModel> fetchInterViewById(int id) {
    final snapshot = ApiService<SingleInterviewModel>().build(
      url: "${ApiUrl.interview}/$id",
      isPublic: false,
      apiType: ApiType.get,
      builder: SingleInterviewModel.fromJson,
    );
    return snapshot;
  }

  Future<SingleInterviewModel> createInterView({
    required int professorId,
    required int subjectId,
    required String title,
    required String meetingTime,
    required String meetingPeriod,
    String? note,
    required List<File> attachments,
  }) {
    final snapshot = ApiService<SingleInterviewModel>().uploadFiles(
     url: ApiUrl.interview,
     builder: SingleInterviewModel.fromJson,
     onRequest: (request) async{
      request.headers['Authorization'] = 'Bearer ${MySharedPreferences.accessToken}';
      request.headers['Content-Type'] = 'application/json';
      request.headers['x-localization'] = MySharedPreferences.language;
      request.fields['professor_id'] = professorId.toString();
      request.fields['subject_id'] = subjectId.toString();
      request.fields['topic'] = title;
      request.fields['meeting_time'] = meetingTime;
      request.fields['meeting_period'] = meetingPeriod;
      if(note!=null) request.fields['note'] = note;
      for(var i=0; i<=attachments.length;i++){
        var file=attachments[i];
        var stream= http.ByteStream(file.openRead());
        var length = await file.length();
        var multipartFile = http.MultipartFile('attachments[$i]', stream, length, filename: file.path.split('/').last);
        request.files.add(multipartFile);
      }
     }
    ); 
    return snapshot;
  }
}
