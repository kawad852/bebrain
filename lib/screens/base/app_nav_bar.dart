import 'package:bebrain/screens/base/widgets/nav_bar_item.dart';
import 'package:bebrain/screens/home/home_screen.dart';
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
    MyIcons.search,
    MyIcons.profile,
  ];

  List<String> _getTitle(BuildContext context) {
    return [
      "Home",
      "Duties",
      "Explanation",
      "Search",
      "Profile",
    ];
  }

  final screens = [
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      bottomNavigationBar: SizedBox(
        height: withNotch ? 95 : 85,
        width: context.mediaQuery.width,
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
              icon: items[index],
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
