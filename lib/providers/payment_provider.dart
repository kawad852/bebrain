import 'package:bebrain/alerts/errors/app_error_feedback.dart';
import 'package:bebrain/alerts/loading/app_over_loader.dart';
import 'package:bebrain/model/order_model.dart';
import 'package:bebrain/model/subscriptions_model.dart';
import 'package:bebrain/network/api_service.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/upayments/upayment.dart';
import 'package:flutter/material.dart';

class PaymentProvider extends ChangeNotifier {
  Future subscribe(
    BuildContext context, {
    required int id,
    required String subscriptionsType,
    required String orderType,
    required double amount,
    Function? afterPay,
  }) async {
    AppOverlayLoader.show();
    await ApiFutureBuilder<SubscriptionsModel>().fetch(
      context,
      withOverlayLoader: false, 
      future: () async {
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
        );
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
    Function? afterPay,
    bool withOverlayLoader = false,
  }) async {
    if(withOverlayLoader){
      AppOverlayLoader.show();
    }
    ApiFutureBuilder<OrderModel>().fetch(
      context, 
      withOverlayLoader: false,
      future: () async {
      final order = context.mainProvider.createOrder(
        type: orderType,
        orderableId: orderableId,
        amount: amount,
      );
      return order;
    }, onComplete: (snapshot) {
      if (snapshot.code == 200) {
        UPayment.checkout(
          context: context,
          orderId: snapshot.data!.orderNumber!,
          amount: amount,
          afterPay: afterPay,
        );
      }
    }, onError: (failure) {
      if(afterPay != null){
        afterPay();
      }
      AppOverlayLoader.hide();
      AppErrorFeedback.show(context, failure);
    });
  }

  Future pay(
    BuildContext context,{
      int? subscribtionId,
      String? subscriptionsType,
      String? orderId,
      Function? afterPay,
      required int id,
      required double amount,
      required String orderType,
    }
  ) async{
    if(orderId != null){
     return  UPayment.checkout(
        context: context,
        withOverlayLoader: true,
        orderId: orderId, 
        amount: amount,
        afterPay: afterPay,
       );
    }
    else if(subscribtionId != null){
      return createOrder(
        context,
        withOverlayLoader: true,
        amount: amount,
        orderType: orderType,
        orderableId: subscribtionId,
        afterPay: afterPay,
      );
    }
    else{
     return subscribe(
        context,
        orderType: orderType,
        subscriptionsType: subscriptionsType!,
        amount: amount,
        id: id,
        afterPay: afterPay,
      );
    }
  }
}
