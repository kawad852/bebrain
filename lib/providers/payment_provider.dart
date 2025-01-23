import 'dart:developer';

import 'package:bebrain/alerts/errors/app_error_feedback.dart';
import 'package:bebrain/alerts/feedback/app_feedback.dart';
import 'package:bebrain/alerts/loading/app_over_loader.dart';
import 'package:bebrain/helper/purchases_service.dart';
import 'package:bebrain/helper/ui_helper.dart';
import 'package:bebrain/model/order_model.dart';
import 'package:bebrain/model/subscriptions_model.dart';
import 'package:bebrain/network/api_service.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/enums.dart';
import 'package:bebrain/utils/upayments/upayment.dart';
import 'package:flutter/material.dart';

class PaymentProvider extends ChangeNotifier {
  Future subscribe(
    BuildContext context, {
    required int id,
    required String subscriptionsType,
    required String orderType,
    required double amount,
    required String title,
    required String? productId,
    required String paymentMethod,
    String? description,
    Function? afterPay,
  }) async {
    AppOverlayLoader.show();
    await ApiFutureBuilder<SubscriptionsModel>().fetch(context, withOverlayLoader: false, future: () async {
      final subscribe = context.mainProvider.subscribe(
        type: subscriptionsType,
        id: id,
      );
      return subscribe;
    }, onComplete: (snapshot) {
      if (snapshot.code == 200) {
        createOrder(
          context,
          orderType: orderType,
          paymentMethod: paymentMethod,
          orderableId: snapshot.data!.id!,
          amount: double.parse(amount.toStringAsFixed(2)),
          afterPay: afterPay,
          productId: productId,
          title: title,
          description: description,
        );
      } else {
        AppOverlayLoader.hide();
        context.showSnackBar(context.appLocalization.generalError);
      }
    }, onError: (failure) {
      AppOverlayLoader.hide();
      AppErrorFeedback.show(context, failure);
    });
  }

  Future createOrder(
    BuildContext context, {
    required String orderType,
    required int orderableId,
    required double amount,
    required String title,
    required String? productId,
    required String paymentMethod,
    String? description,
    Function? afterPay,
    bool withOverlayLoader = false,
  }) async {
    if (withOverlayLoader) {
      AppOverlayLoader.show();
    }
    ApiFutureBuilder<OrderModel>().fetch(context, withOverlayLoader: false, future: () async {
      final order = context.mainProvider.createOrder(
        type: orderType,
        orderableId: orderableId,
        amount: double.parse(amount.toStringAsFixed(2)),
      );
      return order;
    }, onComplete: (snapshot) async {
      log("ProductId:::: $productId");
      if (snapshot.code == 200) {
        if (paymentMethod == PaymentMethodType.inAppPurchases) {
          await PurchasesService.buy(
            context,
            productId ?? "dash_consumable_2k",
            title: title,
            description: description ?? "",
            price: double.parse(amount.toStringAsFixed(2)),
            afterPay: afterPay,
          );
        } else {
          await UPayment.checkout(
            context: context,
            orderId: snapshot.data!.orderNumber!,
            amount: double.parse(amount.toStringAsFixed(2)),
            afterPay: afterPay,
          );
        }
        if (afterPay != null) {
          afterPay();
        }
      } else {
        AppOverlayLoader.hide();
        context.showSnackBar(context.appLocalization.generalError);
      }
    }, onError: (failure) {
      if (afterPay != null) {
        afterPay();
      }
      AppOverlayLoader.hide();
      AppErrorFeedback.show(context, failure);
    });
  }

  Future pay(
    BuildContext context, {
    int? subscribtionId,
    String? subscriptionsType,
    String? orderId,
    Function? afterPay,
    int? id,
    String? discription,
    required String paymentMethod,
    required double amount,
    required String orderType,
    required String title,
    required String? productId,
  }) async {
    if (orderId != null) {
      print("khaled 2222");
      if (paymentMethod == PaymentMethodType.inAppPurchases) {
        await PurchasesService.buy(
          context,
          productId ?? "dash_consumable_2k",
          title: title,
          description: discription ?? "",
          price: double.parse(amount.toStringAsFixed(2)),
          withOverlayLoader: true,
          afterPay: afterPay,
        );
      } else {
        await UPayment.checkout(
          context: context,
          withOverlayLoader: true,
          orderId: orderId,
          amount: double.parse(amount.toStringAsFixed(2)),
          afterPay: afterPay,
        );
      }
      if (afterPay != null) {
        afterPay();
      }
    } else if (subscribtionId != null) {
      return createOrder(
        context,
        paymentMethod: paymentMethod,
        withOverlayLoader: true,
        amount: double.parse(amount.toStringAsFixed(2)),
        orderType: orderType,
        orderableId: subscribtionId,
        afterPay: afterPay,
        productId: productId,
        title: title,
        description: discription,
      );
    } else {
      return subscribe(
        context,
        orderType: orderType,
        paymentMethod: paymentMethod,
        subscriptionsType: subscriptionsType!,
        amount: double.parse(amount.toStringAsFixed(2)),
        id: id!,
        afterPay: afterPay,
        productId: productId,
        title: title,
        description: discription,
      );
    }
  }

  Future fakePayment(BuildContext context,{
    int? subscribtionId,
    String? subscriptionsType,
    String? orderId,
    Function? afterPay,
    int? id,
    String? discription,
    required double amount,
    required String orderType,
    required String title,
    required String? productId,
  }) async {
    if (orderId != null) {
      UiHelper.confirmPayment(context, orderNumber: orderId,afterPay: afterPay);
    } else if (subscribtionId != null) {
      AppOverlayLoader.show();
       ApiFutureBuilder<OrderModel>().fetch(context, withOverlayLoader: false, future: () async {
      final order = context.mainProvider.createOrder(
        type: orderType,
        orderableId: subscribtionId,
        amount: double.parse(amount.toStringAsFixed(2)),
      );
      return order;
    }, onComplete: (snapshot) async {
      if (snapshot.code == 200) {
        UiHelper.confirmPayment(
        context, 
        orderNumber: snapshot.data!.orderNumber!, 
        afterPay: afterPay,
        withOverlayLoader: false,
      );
        if (afterPay != null) {
          afterPay();
        }
      } else {
        AppOverlayLoader.hide();
        context.showSnackBar(context.appLocalization.generalError);
      }
    }, onError: (failure) {
      if (afterPay != null) {
        afterPay();
      }
      AppOverlayLoader.hide();
      AppErrorFeedback.show(context, failure);
    });
    } else {
      AppOverlayLoader.show();
      await ApiFutureBuilder<SubscriptionsModel>().fetch(
        context,
        withOverlayLoader: false,
        future: () async {
          final subscribe = context.mainProvider.subscribe(
          type: subscriptionsType!,
          id: id!,
         );
          return subscribe;
        },
        onComplete: (snapshot) {
          ApiFutureBuilder<OrderModel>().fetch(context, withOverlayLoader: false, future: () async {
            final order = context.mainProvider.createOrder(
              type: orderType,
              orderableId: snapshot.data!.id!,
              amount: double.parse(amount.toStringAsFixed(2)),
            );
            return order;
          }, onComplete: (snapshot) async {
            if (snapshot.code == 200) {
              UiHelper.confirmPayment(
              context, 
              orderNumber: snapshot.data!.orderNumber!, 
              afterPay: afterPay,
              withOverlayLoader: false,
            );
              if (afterPay != null) {
                afterPay();
              }
            } else {
              AppOverlayLoader.hide();
              context.showSnackBar(context.appLocalization.generalError);
            }
          }, onError: (failure) {
            if (afterPay != null) {
              afterPay();
            }
            AppOverlayLoader.hide();
            AppErrorFeedback.show(context, failure);
          });
        },
        onError: (failure) {
          AppOverlayLoader.hide();
          AppErrorFeedback.show(context, failure);
        }
      );
    }

  }
}
