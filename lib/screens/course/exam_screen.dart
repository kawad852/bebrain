import 'package:bebrain/utils/base_extensions.dart';
import 'package:flutter/material.dart';
import 'package:no_screenshot/no_screenshot.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ExamScreen extends StatefulWidget {
  final String payUrl;
  final bool isInitialize;
  const ExamScreen({super.key, required this.payUrl, this.isInitialize = true});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  WebViewController? controller;

  bool isLoading = true;
  final _noScreenshot = NoScreenshot.instance;

    void _changeLoadingStatus(bool status) {
    if (mounted) {
      setState(() {
        isLoading = status;
      });
    }
  }

  void disableScreenshot() async {
    bool result = await _noScreenshot.screenshotOff();
    debugPrint('Screenshot Off: $result');
  }

  void enableScreenshot() async {
    bool result = await _noScreenshot.screenshotOn();
    debugPrint('Enable Screenshot: $result');
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
          onWebResourceError: (WebResourceError error) {
            debugPrint("error::::: $error");
          },
          onNavigationRequest: (NavigationRequest request) async {
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
    if (widget.isInitialize) {
       disableScreenshot();
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.isInitialize) {
      enableScreenshot();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
      ? context.loaders.circular()
      :WebViewWidget(
            controller: controller!,
          ),
    );
  }
}