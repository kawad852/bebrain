import 'package:bebrain/model/auth_model.dart';
import 'package:bebrain/model/filter_model.dart';
import 'package:bebrain/network/api_service.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:flutter/material.dart';

class UiHelper {
  static String getFlag(String code) =>'assets/flags/${code.toLowerCase()}.svg';

  static Future<void> addFilter(
    BuildContext context, {
    required FilterModel filterModel,
    Function? afterAdd,
  }) async {
    if (context.authProvider.isAuthenticated) {
      await ApiFutureBuilder<AuthModel>().fetch(context, future: () async {
        final updateFilter = context.authProvider.updateProfile(
          context, {
          if (filterModel.countryId != null) "country_id": filterModel.countryId,
          if (filterModel.universityId != null) "university_id": filterModel.universityId,
          if (filterModel.collegeId != null) "college_id": filterModel.collegeId,
          if (filterModel.majorId != null) "major_id": filterModel.majorId,
        });
        return updateFilter;
      }, onComplete: (snapshot) async {
        await context.authProvider.updateFilter(context, filterModel: filterModel).then((value) {
          if(afterAdd!=null){
            afterAdd();
          }
        },
      );
     },
   );
    } else {
      if (context.mounted) {
        await context.authProvider.updateFilter(context, filterModel: filterModel).then((value) {
          if(afterAdd!=null){
            afterAdd();
          }
        },
      );
     }
   }
  }
}
