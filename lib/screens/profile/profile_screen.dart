import 'package:bebrain/model/auth_model.dart';
import 'package:bebrain/providers/auth_provider.dart';
import 'package:bebrain/screens/polifcy/policy_screen.dart';
import 'package:bebrain/screens/profile/edit_profile_screen.dart';
import 'package:bebrain/screens/profile/widgets/profile_tile.dart';
import 'package:bebrain/screens/profile/widgets/study_info.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_network_image.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                onPressed: () {
                  context.push(const EditProfileScreen());
                },
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
                  Selector<AuthProvider, UserData>(
                      selector: (context, provider) => provider.user,
                      builder: (context, userData, child) {
                        return Builder(
                          builder: (context) {
                            return Row(
                              children: [
                                CustomNetworkImage(
                                  userData.image!,
                                  width: 53,
                                  height: 53,
                                  shape: BoxShape.circle,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        userData.name!,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
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
                            );
                          },
                        );
                      }),
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
                    onTap: () {
                      context.push(const PolicyScreen(id: 3));
                    },
                    title: context.appLocalization.getKnowAlmusaed,
                    icon: MyIcons.information,
                  ),
                  ProfileTile(
                    onTap: () {
                      context.push(const PolicyScreen(id: 2));
                    },
                    title: context.appLocalization.privacyPolicy,
                    icon: MyIcons.privacyPolicy,
                  ),
                  ProfileTile(
                    onTap: () {
                      context.push(const PolicyScreen(id: 1));
                    },
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
