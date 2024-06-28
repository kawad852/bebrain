import 'dart:developer';

import 'package:bebrain/utils/base_extensions.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatefulWidget {
  final String payUrl;

  const PaymentWebView({
    super.key,
    required this.payUrl,
  });

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  WebViewController? controller;

  bool isLoading = true;

  void _changeLoadingStatus(bool status) {
    if (mounted) {
      setState(() {
        isLoading = status;
      });
    }
  }

  void _initialize(BuildContext context) {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {
            _changeLoadingStatus(false);
          },
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
            log("URL:: ${request.url}");
            if (request.url.contains('https://upayments.com/en/?payment_id')) {
              if (context.mounted) {
                Navigator.pop(context, true);
              }
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.payUrl));
  }

  @override
  void initState() {
    super.initState();
    _initialize(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        alignment: Alignment.center,
        children: [
          WebViewWidget(
            controller: controller!,
          ),
          if (isLoading) context.loaders.circular(),
        ],
      ),
    );
  }
}
