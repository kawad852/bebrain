import 'package:bebrain/utils/base_extensions.dart';
import 'package:flutter/material.dart';

class GeneralErrorWidget extends StatelessWidget {
  const GeneralErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const FaIcon(FontAwesomeIcons.solidCircleExclamation),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Text(
                context.appLocalization.generalErrorTitle,
                style: context.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              context.appLocalization.generalErrorBody,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
