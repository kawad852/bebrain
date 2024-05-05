import 'package:bebrain/screens/base/widgets/nav_bar_item.dart';
import 'package:bebrain/screens/duties/duties_screen.dart';
import 'package:bebrain/screens/graduation_projects/graduation_projects_screen.dart';
import 'package:bebrain/screens/home/home_screen.dart';
import 'package:bebrain/screens/profile/profile_screen.dart';
import 'package:bebrain/screens/special_explanation/special_explanation_screen.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:flutter/material.dart';

class AppNavBar extends StatefulWidget {
  //final bool initFav;
  const AppNavBar({
    super.key,
    //this.initFav = false,
  });

  @override
  State<AppNavBar> createState() => _AppNavBarState();
}

class _AppNavBarState extends State<AppNavBar> {
  int _currentIndex = 0;
  late PageController _pageController;
  // final cloudMessagingService = CloudMessagingService();
  // late AuthProvider authProvider;

  final items = [
    MyIcons.home,
    MyIcons.duties,
    MyIcons.specialExplanation,
    MyIcons.graduation,
    MyIcons.profile,
  ];

  final itemsSelected = [
    MyIcons.homeSelected,
    MyIcons.dutiesSelected,
    MyIcons.specialExplanationSelected,
    MyIcons.graduationSelected,
    MyIcons.profileSelected,
  ];

  List<String> _getTitle(BuildContext context) {
    return [
      context.appLocalization.home,
      context.appLocalization.duties,
      context.appLocalization.explanation,
      context.appLocalization.graduationProjects,
      context.appLocalization.profile,
    ];
  }

  final screens = [
    const HomeScreen(),
    const DutiesScreen(),
    const SpecialExplanationScreen(),
    const GraduationProjectsScreen(),
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
    //authProvider = context.authProvider;
    _pageController = PageController();
    //authProvider.updateDeviceToken(context);
    //cloudMessagingService.init(context);
    //cloudMessagingService.requestPermission();
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
                //  if (index == 0 || index == 1 || index == 2) {
                _onSelect(index);
                //} else {
                //authProvider.checkIfUserAuthenticated(
                //context,
                //callback: () {
                // _onSelect(index);
                //},
                // );
                // }
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
