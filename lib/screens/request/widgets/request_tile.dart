import 'package:bebrain/screens/request/widgets/request_text.dart';
import 'package:bebrain/screens/request/widgets/shared_container.dart';
import 'package:flutter/material.dart';

class RequestTile extends StatelessWidget {
  final String data;
  const RequestTile(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return SharedContainer(
      child: RequestText(data),
    );
  }
}
