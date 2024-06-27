import 'package:bebrain/model/video_view_model.dart';
import 'package:bebrain/providers/main_provider.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/widgets/custom_future_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  final String vimeoId;
  final int videoId;
  const VideoScreen({super.key, required this.vimeoId, required this.videoId});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late MainProvider _mainProvider;
  late Future<VideoViewModel> _videoFuture;

  void _initializeFuture() async {
    _videoFuture = _mainProvider.videoView(widget.videoId);
  }

  @override
  void initState() {
    super.initState();
    _mainProvider = context.mainProvider;
    _initializeFuture();
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
    return Scaffold(
      body: CustomFutureBuilder(
        future: _videoFuture,
        onRetry: () {},
        onError: (snapshot) {
          return VimeoPlayer(
            videoId: widget.vimeoId,
          );
        },
        onComplete: (context, snapshot) {
          return VimeoPlayer(
            videoId: widget.vimeoId,
          );
        },
      ),
    );
  }
}
