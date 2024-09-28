import 'dart:convert';
import 'dart:developer';

import 'package:bebrain/alerts/loading/app_over_loader.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/shared_pref.dart';
import 'package:bebrain/utils/upayments/payment_webview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class UPayment {
  static Future<void> checkout({
    required BuildContext context,
    required String orderId,
    required double amount,
    Function? afterPay,
    bool withOverlayLoader = false,
  }) async {
    try {
      String url = kDebugMode ? 'https://sandboxapi.upayments.com/api/v1/charge' : "https://uapi.upayments.com/api/v1/charge";
      Uri uri = Uri.parse(url);
      var headers = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'Authorization': kDebugMode ? 'Bearer jtest123' : "Bearer 90390e121dcf6b37c596d7641534623e73599067",
      };
      var body = jsonEncode(
        {
          "products": [
            {
              "name": "Logitech K380",
              "description": "Logitech K380 / Easy-Switch for Upto 3 Devices, Slim Bluetooth Tablet Keyboar ",
              "price": 10,
              "quantity": 1,
            },
          ],
          "order": {
            "id": orderId,
            "reference": "11111991",
            "description": "Purchase order received for Logitech K380 Keyboard",
            "currency": MySharedPreferences.user.currencyCode!,
            "amount": amount,
          },
          "language": "en",
          "reference": {
            "id": "202210101202210101",
          },
          "customer": {
            "uniqueId": "${MySharedPreferences.user.id}",
            "name": MySharedPreferences.user.name,
            "email": MySharedPreferences.user.email ?? "",
            "mobile": MySharedPreferences.user.phoneNumber ?? "",
          },
          "returnUrl": "https://almosaaed.com/api/upayment/confirm",
          "cancelUrl": "https://almosaaed.com/api/upayment/fail",
          "notificationUrl": "https://webhook.site/d7c6e1c8-b98b-4f77-8b51-b487540df336",
          "customerExtraData": "User define data"
        },
      );
      if (withOverlayLoader) {
        AppOverlayLoader.show();
      }
      debugPrint("Response:: CheckoutResponse\nUrl:: $url\nheaders:: ${headers.toString()}");
      http.Response response = await http.post(uri, headers: headers, body: body);
      debugPrint("CheckoutStatusCode:: ${response.statusCode} CheckoutBody:: ${response.body}");
      final data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        AppOverlayLoader.hide();
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return PaymentWebView(
                  payUrl: data['data']['link'],
                );
              },
              fullscreenDialog: true,
            ),
          ).then((value) {
            if (value != null) {
              log("success");
              if (afterPay != null) {
                afterPay();
              }
            }
          });
        }
      } else {
        if (afterPay != null) {
          afterPay();
        }
        AppOverlayLoader.hide();
        if (context.mounted) {
          Fluttertoast.showToast(msg: context.appLocalization.generalError);
        }
      }
    } catch (e) {
      debugPrint("$e");
      if (afterPay != null) {
        afterPay();
      }
      if (context.mounted) {
        Fluttertoast.showToast(msg: context.appLocalization.generalError);
      }
    } finally {
      AppOverlayLoader.hide();
    }
  }
}
