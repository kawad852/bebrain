import 'dart:async';
import 'dart:developer';

import 'package:bebrain/alerts/loading/app_over_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class PurchasesService {
  static final InAppPurchase inAppPurchases = InAppPurchase.instance;
  static late StreamSubscription<List<PurchaseDetails>> _purchasesSubscription;

  static Future<void> initialize({
    required Function() onPurchase,
  }) async {
    if (!(await inAppPurchases.isAvailable())) return;
    print("aklsjfalksjfjlaksf");

    _purchasesSubscription = InAppPurchase.instance.purchaseStream.listen(
      (List<PurchaseDetails> purchaseDetailsList) {
        print("id:::: ${purchaseDetailsList.first.productID}");
        _handlePurchaseUpdates(purchaseDetailsList, onPurchase: onPurchase);
      },
      onDone: () {
        _purchasesSubscription.cancel();
      },
      onError: (error) {
        Fluttertoast.showToast(msg: error.toString());
      },
    );
  }

  static void cancel() {
    _purchasesSubscription.cancel();
  }

  static _handlePurchaseUpdates(
    List<PurchaseDetails> purchaseDetailsList, {
    required Function() onPurchase,
  }) async {
    for (final purchaseDetails in purchaseDetailsList) {
      var purchaseStatus = purchaseDetails.status;
      log("purchaseStatus: $purchaseStatus");
      if (purchaseStatus == PurchaseStatus.pending) {
        // handle pending
      } else {
        if (purchaseStatus == PurchaseStatus.error) {
          //handle error
        } else if (purchaseDetails.pendingCompletePurchase) {
          await inAppPurchases.completePurchase(purchaseDetails).then((value) {
            if (purchaseStatus == PurchaseStatus.purchased) {
              //TODO: on purchase success you can call your logic and your API here.
              log("Purchased Successfully");
              onPurchase();
            }
          });
        }
      }
    }
  }

  static Future<void> buy(
    BuildContext context,
    String productId, {
    required String title,
    required String description,
    required double price,
    bool withOverlayLoader = false,
    Function? afterPay,
  }) async {
    try {
      if (withOverlayLoader) {
        AppOverlayLoader.show();
      }
      final productDetails = await inAppPurchases.queryProductDetails({productId});
      if (productDetails.productDetails.isEmpty) {
        Fluttertoast.showToast(msg: "Product Id ($productId) Not Found.");
        return;
      }
      final details = ProductDetails(
        id: productId,
        title: title,
        description: description,
        price: "$price",
        rawPrice: price,
        currencyCode: "USD",
      );
      debugPrint("productId:: ${details.id}\nprice:: ${details.price}\ncurrency:: ${details.currencyCode}");
      final purchaseParam = PurchaseParam(productDetails: details);
      await inAppPurchases.buyNonConsumable(purchaseParam: purchaseParam);
    } catch (e) {
      log("error:: $e");
      Fluttertoast.showToast(msg: "$e");
    } finally {
      AppOverlayLoader.hide();
      if (afterPay != null) {
        afterPay();
      }
    }
  }
}
