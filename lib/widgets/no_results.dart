import 'package:bebrain/utils/base_extensions.dart';
import 'package:flutter/material.dart';

class NoResults extends StatelessWidget {
  final String? title, body;
  final Widget? header, footer;
  final MainAxisAlignment mainAxisAlignment;

  const NoResults({
    super.key,
    this.title,
    this.body,
    this.header,
    this.footer,
    this.mainAxisAlignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          if (header != null) header!,
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                title!,
                style: context.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          if (body != null)
            Text(
              body!,
              textAlign: TextAlign.center,
            ),
          if (footer != null) footer!,
        ],
      ),
    );
  }
}
