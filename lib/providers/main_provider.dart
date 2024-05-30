import 'package:bebrain/model/college_filter_model.dart';
import 'package:bebrain/model/country_filter_model.dart';
import 'package:bebrain/model/major_filter_model.dart';
import 'package:bebrain/model/policy_model.dart';
import 'package:bebrain/model/professors_model.dart';
import 'package:bebrain/model/university_filter_model.dart';
import 'package:bebrain/network/api_service.dart';
import 'package:bebrain/network/api_url.dart';
import 'package:flutter/material.dart';

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

  Future<PolicyModel> fetchPages(int page) {
    final snapshot = ApiService<PolicyModel>().build(
      url: "${ApiUrl.policy}/$page",
      isPublic: true,
      apiType: ApiType.get,
      builder: PolicyModel.fromJson,
    );
    return snapshot;
  }
}
