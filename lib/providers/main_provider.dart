import 'dart:io';

import 'package:bebrain/model/college_filter_model.dart';
import 'package:bebrain/model/country_filter_model.dart';
import 'package:bebrain/model/course_filter_model.dart';
import 'package:bebrain/model/major_filter_model.dart';
import 'package:bebrain/model/new_request_model.dart';
import 'package:bebrain/model/policy_model.dart';
import 'package:bebrain/model/professors_model.dart';
import 'package:bebrain/model/projects_model.dart';
import 'package:bebrain/model/unit_filter_model.dart';
import 'package:bebrain/model/university_filter_model.dart';
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

}
