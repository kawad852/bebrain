import 'package:bebrain/model/auth_model.dart';
import 'package:bebrain/model/filter_model.dart';
import 'package:bebrain/network/api_service.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/enums.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/stretch_button.dart';
import 'package:flutter/material.dart';

class UiHelper extends ChangeNotifier {
  static String getFlag(String code) =>
      'assets/flags/${code.toLowerCase()}.svg';

  Future<void> addFilter(
    BuildContext context, {
    required FilterModel filterModel,
    Function? afterAdd,
  }) async {
    if (context.authProvider.isAuthenticated) {
      await ApiFutureBuilder<AuthModel>().fetch(
        context,
        future: () async {
          final updateFilter = context.authProvider.updateProfile(context, {
            "country_id": filterModel.countryId ?? "",
            "university_id": filterModel.universityId ?? "",
            "college_id": filterModel.collegeId ?? "",
            "major_id": filterModel.majorId ?? "",
          });
          return updateFilter;
        },
        onComplete: (snapshot) async {
          await context.authProvider.updateFilter(context, filterModel: filterModel)
              .then(
            (value) {
              if (afterAdd != null) {
                afterAdd();
              }
            },
          );
        },
      );
      notifyListeners();
    } else {
      if (context.mounted) {
        await context.authProvider.updateFilter(context, filterModel: filterModel)
            .then(
          (value) {
            if (afterAdd != null) {
              afterAdd();
            }
          },
        );
      }
    }
  }

  static Color getRequestColor(BuildContext context, {required String type}) {
    switch (type) {
      case RequestType.pending:
        return context.colorPalette.blue8DD;
      case RequestType.pendingPayment:
        return context.colorPalette.yellowFFC;
      case RequestType.canceled:
        return context.colorPalette.redE42;
      case RequestType.inProgress:
        return context.colorPalette.blue8DD;
      case RequestType.done:
      case RequestType.interviewAdded:
        return context.colorPalette.blueC2E;
      case RequestType.rejected:
        return context.colorPalette.redE42;
      default:
        return context.colorPalette.blue8DD;
    }
  }

  static Future selectFileDialog(
    BuildContext context,{
      required void Function() onTapFiles,
      required void Function() onTapGallery,
    }
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: context.colorPalette.white,
              borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
            ),
            child: Column(
              children: [
                Padding(
                  padding:const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: Text(
                    context.appLocalization.pleaseChoose,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                StretchedButton(
                  onPressed: onTapFiles,
                  margin:const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Text(context.appLocalization.files),
                ),
                StretchedButton(
                  onPressed:onTapGallery,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(context.appLocalization.gallery),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
