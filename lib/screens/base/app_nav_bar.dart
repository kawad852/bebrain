import 'package:bebrain/notifications/cloud_messaging_service.dart';
import 'package:bebrain/providers/auth_provider.dart';
import 'package:bebrain/screens/base/widgets/nav_bar_item.dart';
import 'package:bebrain/screens/duties/duties_screen.dart';
import 'package:bebrain/screens/graduation_projects/graduation_projects_screen.dart';
import 'package:bebrain/screens/home/home_screen.dart';
import 'package:bebrain/screens/online/online_screen.dart';
import 'package:bebrain/screens/profile/profile_screen.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:flutter/material.dart';
import 'package:no_screenshot/no_screenshot.dart';

class AppNavBar extends StatefulWidget {
  const AppNavBar({
    super.key,
  });

  @override
  State<AppNavBar> createState() => _AppNavBarState();
}

class _AppNavBarState extends State<AppNavBar> {
  int _currentIndex = 0;
  late PageController _pageController;
  final cloudMessagingService = CloudMessagingService();
  late AuthProvider authProvider;
  final _noScreenshot = NoScreenshot.instance;

  void enableScreenshot() async {
      bool result = await _noScreenshot.screenshotOn();
      debugPrint('Enable Screenshot: $result');
  }

  final items = [
    MyIcons.home,
    MyIcons.duties,
    MyIcons.onLine,
    // MyIcons.graduation,
    MyIcons.profile,
  ];

  final itemsSelected = [
    MyIcons.homeSelected,
    MyIcons.dutiesSelected,
    MyIcons.onLineSelected,
    // MyIcons.graduationSelected,
    MyIcons.profileSelected,
  ];

  List<String> _getTitle(BuildContext context) {
    return [
      context.appLocalization.home,
      context.appLocalization.duties,
      context.appLocalization.onLine,
      // context.appLocalization.graduationProjects,
      context.appLocalization.profile,
    ];
  }

  final screens = [
    const HomeScreen(),
    const DutiesScreen(),
    const OnlineScreen(),
    // const GraduationProjectsScreen(),
    const ProfileScreen(),
  ];

  void _onSelect(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(_currentIndex);
  }

  @override
  void initState() {
    super.initState();
    enableScreenshot();
    authProvider = context.authProvider;
    _pageController = PageController();
     authProvider.updateDeviceToken(context);
     if(authProvider.isAuthenticated) {
        authProvider.tokenCheck(context);
     }
    cloudMessagingService.requestPermission();
    cloudMessagingService.init(context);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool withNotch = MediaQuery.of(context).viewPadding.bottom > 0.0;
    final Locale myLocale = Localizations.localeOf(context);
    final StringcountryCode = myLocale.countryCode;
    print("StringcountryCode:: $StringcountryCode");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      bottomNavigationBar: Container(
        height: withNotch ? 95 : 85,
        width: context.mediaQuery.width,
        decoration: BoxDecoration(
          color: context.colorPalette.white50,
          boxShadow: [
            BoxShadow(
              color: context.colorPalette.blueC2E,
              offset: const Offset(0.0, 1.0),
              blurRadius: 3.0,
            ),
          ],
        ),
        child: Row(
          children: screens.map((element) {
            final index = screens.indexOf(element);
            return NavBarItem(
              onTap: () {
              if (index == 0 ) {
               _onSelect(index);
              } else {
                   authProvider.checkIfUserAuthenticated(
                   context,
                   callback: () {
                  _onSelect(index);
                  },
                );
              }
             },
              isSelected: _currentIndex == index,
              icon: _currentIndex == index ? itemsSelected[index] : items[index],
              title: _getTitle(context)[index],
            );
          }).toList(),
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: screens,
      ),
    );
  }
}
