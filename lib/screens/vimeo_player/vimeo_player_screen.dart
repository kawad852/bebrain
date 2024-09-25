import 'dart:async';

import 'package:bebrain/model/video_view_model.dart';
import 'package:bebrain/providers/main_provider.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/widgets/custom_future_builder.dart';
import 'package:bebrain/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:no_screenshot/no_screenshot.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VimeoPlayerScreen extends StatefulWidget {
  final String vimeoId;
  final int? videoId;
  const VimeoPlayerScreen(
      {super.key, required this.vimeoId, required this.videoId});

  @override
  State<VimeoPlayerScreen> createState() => _VimeoPlayerScreenState();
}

class _VimeoPlayerScreenState extends State<VimeoPlayerScreen> {
  late MainProvider _mainProvider;
  late Future<VideoViewModel> _videoFuture;
  late WebViewController controller;
  bool showPage = false;
  final _noScreenshot = NoScreenshot.instance;
  // bool _showWatermark = true;
  // Offset _watermarkPosition = const Offset(20, 20);
  // Timer? _timer;

  void _initializeFuture() async {
    _videoFuture = _mainProvider.videoView(widget.videoId!);
  }

  void disableScreenshot() async {
    bool result = await _noScreenshot.screenshotOff();
    debugPrint('Screenshot Off: $result');
  }

  void enableScreenshot() async {
    bool result = await _noScreenshot.screenshotOn();
    debugPrint('Enable Screenshot: $result');
  }

  void _initialize() async {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..enableZoom(false)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            Future.delayed(const Duration(seconds: 2)).then(
              (value) => setState(() {
                showPage = true;
              }),
            );
          },
          onWebResourceError: (WebResourceError error) {
            print('myError::: $error');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadHtmlString('''
    <html>
       <head>
          <style>
             body {
               background-color: lightgray;
               margin: 0px;
              }
          </style>
                <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0">
                <meta http-equiv="Content-Security-Policy" 
                content="default-src * gap:; script-src * 'unsafe-inline' 'unsafe-eval'; connect-src *; 
                img-src * data: blob: android-webview-video-poster:; style-src * 'unsafe-inline';">
        </head>
             <body>
               <iframe 
                src="https://player.vimeo.com/video/${widget.vimeoId}&loop=0&autoplay=0" 
                width="100%" height="100%" frameborder="0" allow="fullscreen" 
                allowfullscreen></iframe>
             </body>
            </html>
    ''', baseUrl: "https://almosaaed.com");
  }

  @override
  void initState() {
    super.initState();
    disableScreenshot();
    _initialize();
    //_startWatermarkAnimation();
    _mainProvider = context.mainProvider;
    if (widget.videoId != null) {
      _initializeFuture();
    }
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    enableScreenshot();
    //_timer?.cancel();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  //  void _startWatermarkAnimation() {
  //   _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
  //     setState(() {
  //       _showWatermark = !_showWatermark;
  //       _updateWatermarkPosition();
  //     });
  //   });
  // }

  // void _updateWatermarkPosition() {
  //   double maxX = MediaQuery.of(context).size.width - 100;
  //   double maxY = MediaQuery.of(context).size.height - 100;
  //   double newX = Random().nextDouble() * maxX;
  //   double newY = Random().nextDouble() * maxY;
  //   _watermarkPosition = Offset(newX, newY);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.videoId == null
          ? !showPage
              ? const CustomLoadingIndicator()
              : WebViewWidget(
                  controller: controller,
                )
          : CustomFutureBuilder(
              future: _videoFuture,
              onRetry: () {},
              onError: (snapshot) {
                return !showPage
                    ? const CustomLoadingIndicator()
                    : WebViewWidget(
                        controller: controller,
                      );
              },
              onComplete: (context, snapshot) {
                return !showPage
                    ? const CustomLoadingIndicator()
                    : WebViewWidget(
                        controller: controller,
                      );
              },
            ),
    );
  }
}
 

   //         if (_showWatermark)
            // Positioned(
            //   left: _watermarkPosition.dx,
            //   top: _watermarkPosition.dy,
            //   child: const Text(
            //     'My Watermark',
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 20,
            //       fontWeight: FontWeight.bold,
            //       shadows: [
            //         Shadow(
            //           offset: Offset(2, 2),
            //           blurRadius: 4,
            //           color: Colors.black54,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),