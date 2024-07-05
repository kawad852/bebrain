import 'package:bebrain/model/auth_model.dart';
import 'package:bebrain/providers/auth_provider.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudyInfo extends StatelessWidget {
  const StudyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<AuthProvider, UserData>(
      selector: (context, provider) => provider.user,
      builder: (context, userData, child) {
        return Builder(
          builder: (context) {
            return Container(
              width: double.infinity,
              height: 61,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: context.colorPalette.greyEEE,
                borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text(
                          "${userData.numberOfCourses}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          context.appLocalization.articles,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: context.colorPalette.grey66,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const CustomSvg(MyIcons.line),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text(
                          "${userData.hours}h , ${userData.minutes} min",
                          style:const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          context.appLocalization.durationStudyWithMusaed,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: context.colorPalette.grey66,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const CustomSvg(MyIcons.line),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text(
                          "${userData.videosCount}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          context.appLocalization.videos,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: context.colorPalette.grey66,
                          ),
                        ),
                      ],
                    ),
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
