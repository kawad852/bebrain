import 'package:bebrain/model/auth_model.dart';
import 'package:bebrain/model/user_model.dart';
import 'package:bebrain/providers/auth_provider.dart';
import 'package:bebrain/screens/article_subscriptions/article_subscriptions_screen.dart';
import 'package:bebrain/screens/booking/booking_screen.dart';
import 'package:bebrain/screens/contact/contact_screen.dart';
import 'package:bebrain/screens/language/language_screen.dart';
import 'package:bebrain/screens/notifications/notifications_screen.dart';
import 'package:bebrain/screens/polifcy/policy_screen.dart';
import 'package:bebrain/screens/profile/edit_profile_screen.dart';
import 'package:bebrain/screens/profile/widgets/profile_loading.dart';
import 'package:bebrain/screens/profile/widgets/profile_tile.dart';
import 'package:bebrain/screens/profile/widgets/study_info.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_future_builder.dart';
import 'package:bebrain/widgets/custom_network_image.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:bebrain/widgets/shimmer/shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with AutomaticKeepAliveClientMixin{
  late AuthProvider _authProvider;
  late Future<UserModel> _userFuture;

  void _initializeFuture() async {
    _userFuture = _authProvider.getUserProfile(context);
  }

  @override
  void initState() {
    super.initState();
    _authProvider = context.authProvider;
    _initializeFuture();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: ()async{
          setState(() {
            _initializeFuture();
          });
        },
        child: CustomScrollView(
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
                    CustomFutureBuilder(
                      future: _userFuture,
                      onLoading: () => const ShimmerLoading(child: ProfileLoading()),
                      onRetry: () {
                        setState(() {
                          _initializeFuture();
                        });
                      },
                      onComplete: (context, snapshot) {
                        return Column(
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
                                                "${context.appLocalization.accountNumber} : ${userData.accountNumber}",
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
                              },
                            ),
                            const StudyInfo(),
                          ],
                        );
                      },
                    ),
                    ProfileTile(
                      onTap: () {
                        context.push(const ArticleSubscriptionsScreen());
                      },
                      title: context.appLocalization.articleSubscriptions,
                      icon: MyIcons.articleSubscriptions,
                    ),
                    ProfileTile(
                      onTap: () {
                        context.push(const BookingScreen());
                      },
                      title: context.appLocalization.appointmentsAndBookings,
                      icon: MyIcons.booking,
                    ),
                    ProfileTile(
                      onTap: () {
                        context.push(const NotificationsScreen());
                      },
                      title: context.appLocalization.notifications,
                      icon: MyIcons.notification,
                    ),
                    ProfileTile(
                      onTap: () {
                        context.push(const LanguageScreen());
                      },
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
                      onTap: () {
                        context.push(const ContactScreen());
                      },
                      title: context.appLocalization.contactAlmusaed,
                      icon: MyIcons.contact,
                    ),
                    ProfileTile(
                      onTap: () {
                        context.authProvider.logout(context);
                      },
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
      ),
    );
  }
  @override
  bool get wantKeepAlive => true;
}
