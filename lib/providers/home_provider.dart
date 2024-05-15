import 'package:bebrain/model/country_filter_model.dart';
import 'package:bebrain/model/university_filter_model.dart';
import 'package:bebrain/network/api_service.dart';
import 'package:bebrain/network/api_url.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  Future<CountryFilterModel> filterByCountry(int countryId) {
    final snapshot = ApiService<CountryFilterModel>().build(
      url: "${ApiUrl.countryFilter}/$countryId",
      isPublic: false,
      apiType: ApiType.get,
      builder: CountryFilterModel.fromJson,
    );
    return snapshot;
  }

  Future<UniversityFilterModel> filterByUniversity(int universityId) {
    final snapshot = ApiService<UniversityFilterModel>().build(
      url: "${ApiUrl.universityFilter}/$universityId",
      isPublic: false,
      apiType: ApiType.get,
      builder: UniversityFilterModel.fromJson,
    );
    return snapshot;
  }
}
