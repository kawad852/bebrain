import 'package:bebrain/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VimeoPlayerScreen extends StatefulWidget {
  final String vimeoId;
  const VimeoPlayerScreen({super.key, required this.vimeoId});

  @override
  State<VimeoPlayerScreen> createState() => _VimeoPlayerScreenState();
}

class _VimeoPlayerScreenState extends State<VimeoPlayerScreen> {
  late WebViewController controller;
  bool showPage = false;

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
    _initialize();
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return !showPage
        ? const CustomLoadingIndicator()
        : WebViewWidget(
            controller: controller,
          );
  }
}
