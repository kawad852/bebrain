import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:flutter/material.dart';

class EductionCard extends StatelessWidget {
  const EductionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 100,
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        decoration: BoxDecoration(
          color: context.colorPalette.blueC2E,
          borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 35,
              height: 39,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: context.colorPalette.blueA3C,
                borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
              ),
              child: Text(
                "10\n%",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: context.colorPalette.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Flexible(
              child: Text(
                "اساسيات البرمجة المتقدمة",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
            Text(
              "10 فيديو ، 2 س",
              style: TextStyle(
                color: context.colorPalette.grey66,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
