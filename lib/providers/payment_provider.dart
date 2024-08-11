import 'dart:developer';

import 'package:bebrain/alerts/errors/app_error_feedback.dart';
import 'package:bebrain/alerts/feedback/app_feedback.dart';
import 'package:bebrain/alerts/loading/app_over_loader.dart';
import 'package:bebrain/helper/purchases_service.dart';
import 'package:bebrain/model/order_model.dart';
import 'package:bebrain/model/subscriptions_model.dart';
import 'package:bebrain/network/api_service.dart';
import 'package:bebrain/utils/base_extensions.dart';
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
    String? description,
    Function? afterPay,
  }) async {
    AppOverlayLoader.show();
    await ApiFutureBuilder<SubscriptionsModel>()
        .fetch(context, withOverlayLoader: false, future: () async {
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
          orderableId: snapshot.data!.id!,
          amount: amount,
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
    String? description,
    Function? afterPay,
    bool withOverlayLoader = false,
  }) async {
    if (withOverlayLoader) {
      AppOverlayLoader.show();
    }
    ApiFutureBuilder<OrderModel>().fetch(context, withOverlayLoader: false,
        future: () async {
      final order = context.mainProvider.createOrder(
        type: orderType,
        orderableId: orderableId,
        amount: amount,
      );
      return order;
    }, onComplete: (snapshot) async {
      log("jjjj");
      if (snapshot.code == 200) {
        await PurchasesService.buy(
          context,
          productId?? "test_22_24",
          title: title,
          description: description??"",
          price: amount,
          afterPay: afterPay,
        );
        //  UPayment.checkout(
        //     context: context,
        //     orderId: snapshot.data!.orderNumber!,
        //     amount: amount,
        //     afterPay: afterPay,
        //   );
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
    required double amount,
    required String orderType,
    required String title,
    required String? productId,
  }) async {
    if (orderId != null) {
      await PurchasesService.buy(
        context,
        productId?? "test_22_24",
        title: title,
        description: discription?? "",
        price: amount,
        withOverlayLoader: true,
        afterPay: afterPay,
      );
      // UPayment.checkout(
      //   context: context,
      //   withOverlayLoader: true,
      //   orderId: orderId,
      //   amount: amount,
      //   afterPay: afterPay,
      //  );
      if (afterPay != null) {
        afterPay();
      }
    } else if (subscribtionId != null) {
      return createOrder(
        context,
        withOverlayLoader: true,
        amount: amount,
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
        subscriptionsType: subscriptionsType!,
        amount: amount,
        id: id!,
        afterPay: afterPay,
        productId: productId,
        title: title,
        description: discription,
      );
    }
  }
}
