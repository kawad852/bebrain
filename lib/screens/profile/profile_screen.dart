import 'package:bebrain/screens/profile/widgets/profile_tile.dart';
import 'package:bebrain/screens/profile/widgets/study_info.dart';
import 'package:bebrain/utils/app_constants.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_network_image.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            leadingWidth: kBarLeadingWith,
            leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              child: Text(
                context.appLocalization.profile,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const CustomSvg(MyIcons.setting),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CustomNetworkImage(
                        kFakeImage,
                        width: 53,
                        height: 53,
                        shape: BoxShape.circle,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Almhyar Zahra",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${context.appLocalization.accountNumber} : 2194625",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: context.colorPalette.grey66,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const StudyInfo(),
                  ProfileTile(
                    onTap: () {},
                    title: context.appLocalization.articleSubscriptions,
                    icon: MyIcons.articleSubscriptions,
                  ),
                  ProfileTile(
                    onTap: () {},
                    title: context.appLocalization.notifications,
                    icon: MyIcons.notification,
                  ),
                  ProfileTile(
                    onTap: () {},
                    title: context.appLocalization.appLanguage,
                    icon: MyIcons.appLanguage,
                  ),
                  ProfileTile(
                    onTap: () {},
                    title: context.appLocalization.getKnowAlmusaed,
                    icon: MyIcons.information,
                  ),
                  ProfileTile(
                    onTap: () {},
                    title: context.appLocalization.privacyPolicy,
                    icon: MyIcons.privacyPolicy,
                  ),
                  ProfileTile(
                    onTap: () {},
                    title: context.appLocalization.termsAndConditions,
                    icon: MyIcons.terms,
                  ),
                  ProfileTile(
                    onTap: () {},
                    title: context.appLocalization.contactAlmusaed,
                    icon: MyIcons.contact,
                  ),
                  ProfileTile(
                    onTap: () {},
                    title: context.appLocalization.logout,
                    icon: MyIcons.logout,
                    color: context.colorPalette.redE66,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
