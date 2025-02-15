import 'dart:io';

import 'package:bebrain/alerts/errors/app_error_feedback.dart';
import 'package:bebrain/alerts/feedback/app_feedback.dart';
import 'package:bebrain/alerts/loading/app_over_loader.dart';
import 'package:bebrain/model/auth_model.dart';
import 'package:bebrain/model/confirm_pay_model.dart';
import 'package:bebrain/model/filter_model.dart';
import 'package:bebrain/network/api_service.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/enums.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/stretch_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UiHelper extends ChangeNotifier {
  static String getFlag(String code) => 'assets/flags/${code.toLowerCase()}.svg';

  Future<void> addFilter(
    BuildContext context, {
    required FilterModel filterModel,
    Function? afterAdd,
  }) async {
    if (context.authProvider.isAuthenticated) {
      await ApiFutureBuilder<AuthModel>().fetch(
        context,
        future: () async {
          final updateFilter = context.authProvider.updateProfile(context, {
            "country_id": filterModel.countryId ?? "",
            "university_id": filterModel.universityId ?? "",
            "college_id": filterModel.collegeId ?? "",
            "major_id": filterModel.majorId ?? "",
          });
          return updateFilter;
        },
        onError: (failure) {
          context.showSnackBar(failure.code);
        },
        onComplete: (snapshot) async {
          if (snapshot.code != 200) {
            context.showSnackBar(snapshot.msg ?? context.appLocalization.generalError);
            return;
          }
          await context.authProvider.updateFilter(context, filterModel: filterModel).then(
            (value) {
              if (afterAdd != null) {
                afterAdd();
              }
            },
          );
        },
      );
      notifyListeners();
    } else {
      if (context.mounted) {
        await context.authProvider.updateFilter(context, filterModel: filterModel).then(
          (value) {
            if (afterAdd != null) {
              afterAdd();
            }
          },
        );
      }
    }
  }

  static Color getRequestColor(BuildContext context, {required String type}) {
    switch (type) {
      case RequestType.pending:
        return context.colorPalette.blue8DD;
      case RequestType.pendingPayment:
        return context.colorPalette.yellowFFC;
      case RequestType.canceled:
        return context.colorPalette.redE42;
      case RequestType.inProgress:
        return context.colorPalette.blue8DD;
      case RequestType.done:
      case RequestType.interviewAdded:
        return context.colorPalette.blueC2E;
      case RequestType.rejected:
        return context.colorPalette.redE42;
      default:
        return context.colorPalette.blue8DD;
    }
  }

  static Future selectFileDialog(
    BuildContext context, {
    required void Function() onTapFiles,
    required void Function() onTapGallery,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: context.colorPalette.white,
              borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: Text(
                    context.appLocalization.pleaseChoose,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                StretchedButton(
                  onPressed: onTapFiles,
                  margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Text(context.appLocalization.files),
                ),
                StretchedButton(
                  onPressed: onTapGallery,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(context.appLocalization.gallery),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void whatsAppContact(BuildContext context) async {
    var contactNumber = "+96555800822";
    var androidUrl = "whatsapp://send?phone=$contactNumber";
    var iosUrl = "https://wa.me/$contactNumber";
    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else if (Platform.isAndroid) {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      if (context.mounted) {
        context.showSnackBar(context.appLocalization.installWhatsApp);
      }
    }
  }

  static Future<void> confirmPayment(
    BuildContext context, {
    required String orderNumber,
    Function? afterPay,
    bool withOverlayLoader = true,
  }) async {
    await ApiFutureBuilder<ConfirmPayModel>().fetch(
      context,
      withOverlayLoader: withOverlayLoader,
      future: () async {
        final confirmPay = context.mainProvider.confirmPayment(orderNumber);
        return confirmPay;
      },
      onComplete: (snapshot) {
        AppOverlayLoader.hide();
        if (snapshot.code == 200 && afterPay != null) {
          afterPay();
        }
      },
      onError: (failure) {
        if (afterPay != null) {
          afterPay();
        }
        AppOverlayLoader.hide();
        AppErrorFeedback.show(context, failure);
      },
    );
  }

  static Future selectPaymentDialog(
    BuildContext context, {
    required void Function() onUpayment,
    required void Function() onAppPurchases,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: context.colorPalette.white,
              borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: Text(
                    context.appLocalization.choosePaymentMethod,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                StretchedButton(
                  onPressed: onUpayment,
                  margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: const Text("Upayment"),
                ),
                StretchedButton(
                  onPressed: onAppPurchases,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: const Text("In App Purchases"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void payment(
    BuildContext context, {
    required String? productId,
    required String title,
    String? discription,
    Function? afterPay,
    int? id,
    required double amount,
    required String orderType,
    String? subscriptionsType,
    required int? subscribtionId,
    String? orderId,
  }) {
    Platform.isAndroid
        ? selectPaymentDialog(
            context,
            onUpayment: () {
              context.pop();
              context.paymentProvider.pay(
                context,
                paymentMethod: PaymentMethodType.upayment,
                productId: productId,
                title: title,
                discription: discription,
                id: id,
                amount: amount,
                orderType: orderType,
                subscriptionsType: subscriptionsType,
                subscribtionId: subscribtionId,
                orderId: orderId,
                afterPay: afterPay,
              );
            },
            onAppPurchases: () {
              context.pop();
              context.paymentProvider.pay(
                context,
                paymentMethod: PaymentMethodType.inAppPurchases,
                productId: productId,
                title: title,
                discription: discription,
                id: id,
                amount: amount,
                orderType: orderType,
                subscriptionsType: subscriptionsType,
                subscribtionId: subscribtionId,
                orderId: orderId,
                afterPay: afterPay,
              );
            },
          )
        : context.paymentProvider.pay(
            context,
            paymentMethod: PaymentMethodType.inAppPurchases,
            productId: productId,
            title: title,
            discription: discription,
            id: id,
            amount: amount,
            orderType: orderType,
            subscriptionsType: subscriptionsType,
            subscribtionId: subscribtionId,
            orderId: orderId,
            afterPay: afterPay,
          );
  }
}
