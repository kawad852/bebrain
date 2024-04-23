import 'package:bebrain/screens/home/widgets/appbar_text.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:flutter/material.dart';

class MySubscription extends StatefulWidget {
  const MySubscription({super.key});

  @override
  State<MySubscription> createState() => _MySubscriptionState();
}

class _MySubscriptionState extends State<MySubscription> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppBarText(context.appLocalization.hello),
              Flexible(
                child: AppBarText(
                  "Almhyar Zahra",
                  overflow: TextOverflow.ellipsis,
                  textColor: context.colorPalette.black33,
                ),
              ),
              const Text(
                "👋",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
            ],
          ),
          const Row(
            children: [
              Text("🇯🇴"),
              Flexible(
                child: AppBarText(
                  "/ الجامعة الأردنية / كلية الملك عبدالله",
                  overflow: TextOverflow.ellipsis,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
