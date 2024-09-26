import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bebrain/notifications/local_notifications_service.dart';
import 'package:bebrain/providers/app_provider.dart';
import 'package:bebrain/providers/auth_provider.dart';
import 'package:bebrain/providers/main_provider.dart';
import 'package:bebrain/providers/payment_provider.dart';
import 'package:bebrain/screens/base/app_nav_bar.dart';
import 'package:bebrain/screens/intro/intro_screen.dart';
import 'package:bebrain/screens/registration/registration_screen.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/enums.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/utils/shared_pref.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
  await Firebase.initializeApp(
    options: Platform.isAndroid
        ? const FirebaseOptions(
            apiKey: "AIzaSyBx-u_p9-gXqy7KjbmfF12UAvWNMlsd-ww",
            authDomain: "almosaedapp.firebaseapp.com",
            projectId: "almosaedapp",
            storageBucket: "almosaedapp.appspot.com",
            messagingSenderId: "97702859580",
            appId: "1:97702859580:web:d355a19b08456fedb14439",
            measurementId: "G-NTPXWDYBY0",
          )
        : null,
  );
  unawaited(AppProvider.getCountryCode());
  await MySharedPreferences.init();
  // FlutterBranchSdk.validateSDKIntegration();
  //MySharedPreferences.clearStorage();
  // MySharedPreferences.isPassedIntro = false;
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => AppProvider()),
        ChangeNotifierProvider(create: (context) => MainProvider()),
        ChangeNotifierProvider(create: (context) => PaymentProvider()),
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
  if (MySharedPreferences.accessToken != '' && _authProvider.wizardValues.countryId != null) {
      return const AppNavBar();
  } else {
    if (MySharedPreferences.isPassedIntro) {
        return const RegistrationScreen();
    } else {
        return const IntroScreen();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _authProvider = context.authProvider;
    _authProvider.initUser();
    _authProvider.initFilter();
    LocalNotificationsService.androidChannel = const AndroidNotificationChannel(
      'cnid', // id
      'cnid channel', // title
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
      playSound: true,
      // sound: RawResourceAndroidNotificationSound('notification'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, child) {
        final isLight = appProvider.appTheme == ThemeEnum.light;
        var seedColorScheme = ColorScheme.fromSeed(
          seedColor: const Color(0xFFC2E7D6),
          brightness: isLight ? Brightness.light : Brightness.dark,
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
