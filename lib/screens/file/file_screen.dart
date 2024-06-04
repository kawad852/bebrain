import 'package:bebrain/utils/base_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class FileScreen extends StatefulWidget {
  final String url;
  final String fileName;
  const FileScreen({super.key, required this.url, required this.fileName});

  @override
  State<FileScreen> createState() => _FileScreenState();
}

class _FileScreenState extends State<FileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fileName),
      ),
      body: const PDF().cachedFromUrl(
        widget.url,
        placeholder: (double progress) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              Text('$progress %'),
            ],
          ),
        ),
        errorWidget: (dynamic error) => Center(child: Text(context.appLocalization.generalError)),
      ),
    );
  }
}
