import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/shimmer/shimmer_bubble.dart';
import 'package:bebrain/widgets/shimmer/shimmer_loading.dart';
import 'package:bebrain/widgets/titled_textfield.dart';
import 'package:flutter/material.dart';

class SendRequestLoading extends StatelessWidget {
  final String discription;
  const SendRequestLoading({super.key, required this.discription});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(pinned: true),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.appLocalization.sendRequest,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      discription,
                      style: TextStyle(
                        color: context.colorPalette.grey66,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  TitledTextField(
                    title: "${context.appLocalization.country} *",
                    child: const ShimmerLoading(
                      child: LoadingBubble(
                        width: double.infinity,
                        height: 48,
                        radius: MyTheme.radiusSecondary,
                      ),
                    ),
                  ),
                  TitledTextField(
                    title: "${context.appLocalization.university} *",
                    child: const ShimmerLoading(
                      child: LoadingBubble(
                        width: double.infinity,
                        height: 48,
                        radius: MyTheme.radiusSecondary,
                      ),
                    ),
                  ),
                  TitledTextField(
                    title: "${context.appLocalization.college} *",
                    child: const ShimmerLoading(
                      child: LoadingBubble(
                        width: double.infinity,
                        height: 48,
                        radius: MyTheme.radiusSecondary,
                      ),
                    ),
                  ),
                  TitledTextField(
                    title: "${context.appLocalization.specialization} *",
                    child: const ShimmerLoading(
                      child: LoadingBubble(
                        width: double.infinity,
                        height: 48,
                        radius: MyTheme.radiusSecondary,
                      ),
                    ),
                  ),
                  TitledTextField(
                    title: "${context.appLocalization.title} *",
                    child: const ShimmerLoading(
                      child: LoadingBubble(
                        width: double.infinity,
                        height: 48,
                        radius: MyTheme.radiusSecondary,
                      ),
                    ),
                  ),
                  TitledTextField(
                    title: "${context.appLocalization.notes} *",
                    child: const ShimmerLoading(
                      child: LoadingBubble(
                        width: double.infinity,
                        height: 120,
                        radius: MyTheme.radiusSecondary,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: ShimmerLoading(
                      child: LoadingBubble(
                        width: 220,
                        height: 52,
                        radius: MyTheme.radiusSecondary,
                      ),
                    ),
                  ),
                  const ShimmerLoading(
                    child: LoadingBubble(
                      width: double.infinity,
                      height: 55,
                      radius: MyTheme.radiusSecondary,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
