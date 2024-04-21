import 'package:bebrain/utils/base_extensions.dart';
import 'package:flutter/material.dart';

class VexLoader extends StatelessWidget {
  final double topSpace;
  final double bottomSpace;
  final bool isFetchingMore;

  const VexLoader(
    this.isFetchingMore, {
    super.key,
    this.topSpace = 40,
    this.bottomSpace = 40,
  });

  @override
  Widget build(BuildContext context) {
    if (isFetchingMore) {
      return Padding(
        padding: EdgeInsets.only(top: topSpace, bottom: bottomSpace),
        child: context.loaders.circular(isSmall: true),
      );
    }
    return const SizedBox.shrink();
  }
}
