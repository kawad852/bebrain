import 'dart:async';
import 'dart:developer';

import 'package:bebrain/notifications/local_notifications_service.dart';
import 'package:bebrain/providers/app_provider.dart';
import 'package:bebrain/providers/auth_provider.dart';
import 'package:bebrain/screens/intro/intro_screen.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/enums.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/utils/shared_pref.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

// mhyar

final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "Main Navigator");

@pragma('vm:entry-point')
Future<void> onBackgroundMessage(RemoteMessage message) async {
  final data = message.notification;
  log("ReceivedNotification::\nType::onBackgroundMessage\nTitle:: ${data?.title}\nBody:: ${data?.body}\nData::${message.data}");
}

// before merge

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await MySharedPreferences.init();
  // FlutterBranchSdk.validateSDKIntegration();
  // MySharedPreferences.clearStorage();
  // MySharedPreferences.isPassedIntro = false;
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => AppProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AuthProvider _authProvider;

  Widget _toggleRoute(BuildContext context) {
    return const IntroScreen();
    // if (_authProvider.user.id != null) {
    //   return const AppNavBar(initFav: true);
    // } else {
    //   if (MySharedPreferences.isPassedIntro) {
    //     return const RegistrationScreen();
    //   } else {
    //     return const IntroScreen();
    //   }
    // }
  }

  @override
  void initState() {
    super.initState();
    _authProvider = context.authProvider;
    _authProvider.initUser();
    LocalNotificationsService.androidChannel = const AndroidNotificationChannel(
      'cnid', // id
      'cnid channel', // title
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
      playSound: true,
      // sound: RawResourceAndroidNotificationSound('notification'),
    );
    final countryCode = PlatformDispatcher.instance.locale.countryCode;
    print("countryCode:: $countryCode");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        final isLight = appProvider.appTheme == ThemeEnum.light;
        var seedColorScheme = ColorScheme.fromSeed(
          seedColor: const Color(0xFF333333),
          brightness: isLight ? Brightness.light : Brightness.dark,
        );
        seedColorScheme = seedColorScheme.copyWith(
          primary: isLight ? const Color(0xFF032D4B) : null,
        );
        return MaterialApp(
          navigatorKey: navigatorKey,
          builder: EasyLoading.init(),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale(appProvider.appLocale.languageCode),
          theme: MyTheme().materialTheme(context, seedColorScheme),
          home: _toggleRoute(context),
          // home: const PaginationTestScreen(),
        );
      },
    );
  }
}
