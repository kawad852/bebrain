import 'package:bebrain/model/user_model.dart';
import 'package:bebrain/utils/app_constants.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_network_image.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:bebrain/widgets/custom_text_field.dart';
import 'package:bebrain/widgets/evaluation_star.dart';
import 'package:flutter/material.dart';

class LecturersScreen extends StatefulWidget {
  const LecturersScreen({super.key});

  @override
  State<LecturersScreen> createState() => _LecturersScreenState();
}

class _LecturersScreenState extends State<LecturersScreen> {
  final TextEditingController _searchController = TextEditingController();

  final user = UserModel();

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
                    context.appLocalization.lecturers,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CustomTextField(
                      controller: _searchController,
                      hintText: context.appLocalization.searchLectureName,
                      prefixIcon: const IconButton(
                        onPressed: null,
                        icon: CustomSvg(MyIcons.search),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.9),
              delegate: SliverChildBuilderDelegate(
                childCount: 8,
                (context, index) {
                  return Container(
                    height: 185,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                      color: context.colorPalette.greyEEE,
                      borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                    ),
                    child: Column(
                      children: [
                        CustomNetworkImage(
                          kFakeImage,
                          width: 91,
                          height: 91,
                          shape: BoxShape.circle,
                          alignment: context.isLTR ? Alignment.topLeft : Alignment.topRight,
                          child: const EvaluationStar(
                            evaluation: "4.8",
                          ),
                        ),
                        const Flexible(
                          child: Text(
                            "د. عبدالله محمد",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            "الجامعة الأردنية",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: context.colorPalette.grey66,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            "4900 ${context.appLocalization.subscriber}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: context.colorPalette.grey66,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
