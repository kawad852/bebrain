import 'package:bebrain/widgets/request_text.dart';
import 'package:bebrain/screens/request/widgets/shared_container.dart';
import 'package:flutter/material.dart';

class RequestTile extends StatelessWidget {
  final String data;
  final double fontSize;
  const RequestTile(this.data, {super.key, this.fontSize =14});

  @override
  Widget build(BuildContext context) {
    return SharedContainer(
      child: RequestText(data,fontSize: fontSize),
    );
  }
}
