import 'dart:developer';
import 'dart:io' show Platform;

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bebrain/alerts/feedback/app_feedback.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:url_launcher/url_launcher.dart';

enum SocialPlatformEnum { facebook, instagram, twitter }

class LauncherHelper {
  static const String mobileNum1 = '+8618814815896';
  static const String mobileNum2 = '+16892853655';
  static const String whatsAppNum = '+08618814815896';
  static const String email = 'info@varvox.com';
  static const String _facebookPageId = '100057517656484';
  static const String _facebookUsername = 'varvoxlogistics';
  static const String _instagramUsername = 'varvox_express';
  static const String _twitterUsername = 'varvox';
  static const String _linkedInUserName = 'varvox';

  ///url
  //facebook
  static String get facebookNativeUrl => Platform.isAndroid ? "fb://page/$_facebookPageId" : "fb://profile/$_facebookPageId";
  static const String facebookWebUrl = "https://web.facebook.com/$_facebookUsername";
  //instagram
  static const String instagramNativeUrl = "instagram://user?username=$_instagramUsername";
  static const String instagramWebUrl = "https://www.instagram.com/$_instagramUsername/";
  //twitter
  static const String twitterNativeUrl = "twitter:///user?screen_name=$_twitterUsername";
  static const String twitterWebUrl = "https://twitter.com/$_twitterUsername";
  //linkedin
  static const String linkedInWebUrl = "https://www.linkedin.com/in/$_linkedInUserName";
  //phone, whatsApp and email
  static String get whatsAppUrl => Platform.isAndroid ? "https://wa.me/$whatsAppNum/" : "https://api.whatsapp.com/send?phone=$whatsAppNum";
  static const String mobileNum1Url = 'tel://$mobileNum1';
  static const String mobileNum2Url = 'tel://$mobileNum2';
  static const String emailUrl = 'mailto:$email';

  static String getPhoneNum(String number) => 'tel://$number';

  static Future<void> lunchSocialMedia(
    BuildContext context, {
    required String nativeUrl,
    required String webUrl,
    SocialPlatformEnum? type,
  }) async {
    try {
      final nativeUri = Uri.parse(nativeUrl);
      final webUri = Uri.parse(webUrl);
      final canLaunch = await canLaunchUrl(nativeUri);
      if (kIsWeb) {
        if (canLaunch) {
          await launchUrl(webUri);
        } else {
          throw "Could not launch $webUrl";
        }
        return;
      }
      if (Platform.isAndroid) {
        if (type == SocialPlatformEnum.facebook) {
          final url2 = "fb://facewebmodal/f?href=$nativeUrl";
          final intent2 = AndroidIntent(action: "action_view", data: url2);
          final canWork = await intent2.canResolveActivity();
          if (canWork ?? false) return intent2.launch();
        }
        final intent = AndroidIntent(action: "action_view", data: nativeUrl);
        return intent.launch();
      } else {
        if (canLaunch) {
          await launchUrl(nativeUri, mode: LaunchMode.externalApplication);
        } else {
          await launchUrl(webUri, mode: LaunchMode.externalApplication);
        }
      }
    } catch (e) {
      log("UrlLauncherError:: $e");
      if (context.mounted) {
        context.showSnackBar(context.appLocalization.generalError);
      }
    }
  }

  /// mobileNum, whatsapp and email
  static Future<void> lunch(BuildContext context, String path) async {
    try {
      final uri = Uri.parse(path);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      log("UrlLauncherError:: $e");
      if (context.mounted) {
        context.showSnackBar(context.appLocalization.generalError);
      }
    }
  }

  ///maps
  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    final uri = Uri.parse(googleUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not open the map.';
    }
  }
}
