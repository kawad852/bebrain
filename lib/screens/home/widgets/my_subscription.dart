import 'package:bebrain/helper/ui_helper.dart';
import 'package:bebrain/model/auth_model.dart';
import 'package:bebrain/model/filter_model.dart';
import 'package:bebrain/providers/auth_provider.dart';
import 'package:bebrain/screens/home/widgets/appbar_text.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/shared_pref.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MySubscription extends StatefulWidget {
  const MySubscription({super.key});

  @override
  State<MySubscription> createState() => _MySubscriptionState();
}

class _MySubscriptionState extends State<MySubscription> {
  @override
  Widget build(BuildContext context) {
    return context.authProvider.isAuthenticated
        ? Selector<AuthProvider, UserData>(
            selector: (context, provider) => provider.user,
            builder: (context, userData, child) {
              String getUserEducation() {
                if (userData.universityName == null) {
                  return "";
                } else {
                  return userData.collegeName != null
                      ? "/${userData.universityName}/ ${userData.collegeName}"
                      : "/${userData.universityName!}";
                }
              }

              return Builder(
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsetsDirectional.only(start: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            AppBarText(context.appLocalization.hello),
                            Flexible(
                              child: AppBarText(
                                userData.name ?? "",
                                overflow: TextOverflow.ellipsis,
                                textColor: context.colorPalette.black33,
                              ),
                            ),
                            const Text(
                              "👋",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            CustomSvg(
                              UiHelper.getFlag(userData.countryCode ??
                                  MySharedPreferences.filter.countryCode!),
                              width: 20,
                            ),
                            Flexible(
                              child: AppBarText(
                                getUserEducation(),
                                overflow: TextOverflow.ellipsis,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          )
        : Selector<AuthProvider, FilterModel>(
            selector: (context, provider) => provider.wizardValues,
            builder: (context, wizardValues, child) {
              String getUserEducation() {
                if (wizardValues.universityName == null) {
                  return "";
                } else {
                  return wizardValues.collegeName != null
                      ? "/${wizardValues.universityName}/ ${wizardValues.collegeName}"
                      : "/${wizardValues.universityName!}";
                }
              }

              return Builder(
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsetsDirectional.only(start: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            AppBarText(context.appLocalization.hello),
                            Flexible(
                              child: AppBarText(
                                "",
                                overflow: TextOverflow.ellipsis,
                                textColor: context.colorPalette.black33,
                              ),
                            ),
                            const Text(
                              "👋",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            CustomSvg(
                              UiHelper.getFlag(wizardValues.countryCode!),
                              width: 20,
                            ),
                            Flexible(
                              child: AppBarText(
                                getUserEducation(),
                                overflow: TextOverflow.ellipsis,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
  }
}
