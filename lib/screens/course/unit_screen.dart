import 'package:bebrain/model/unit_filter_model.dart';
import 'package:bebrain/providers/main_provider.dart';
import 'package:bebrain/screens/course/widgets/course_nav_bar.dart';
import 'package:bebrain/screens/course/widgets/course_text.dart';
import 'package:bebrain/screens/course/widgets/leading_back.dart';
import 'package:bebrain/screens/course/widgets/part_card.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_future_builder.dart';
import 'package:bebrain/widgets/stretch_button.dart';
import 'package:flutter/material.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';

class UnitScreen extends StatefulWidget {
  final int unitId;
  const UnitScreen({super.key, required this.unitId});

  @override
  State<UnitScreen> createState() => _UnitScreenState();
}

class _UnitScreenState extends State<UnitScreen> {
  
  late MainProvider _mainProvider;
  late Future<UnitFilterModel> _unitFuture;

  void _initializeFuture() async {
    _unitFuture = _mainProvider.filterByUnit(widget.unitId);
  }

  bool checkTime(DateTime firstDate, DateTime lastDate){
    return (firstDate.toUTC(context).compareTo(DateTime.now())==0 ||  DateTime.now().isAfter(firstDate.toUTC(context))) &&
      (lastDate.toUTC(context).compareTo(DateTime.now())==0 ||  DateTime.now().isBefore(lastDate.toUTC(context)));
  }

  @override
  void initState() {
    super.initState();
    _mainProvider = context.mainProvider;
    _initializeFuture();
    
  }

  
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      future: _unitFuture,
      withBackgroundColor: true,
      onRetry: () {
        setState(() {
          _initializeFuture();
        });
      },
      onComplete: (context, snapshot) {
        final data=snapshot.data!;
        final unit=data.data!;
        return Scaffold(
          bottomNavigationBar: unit.courseOffer==null || !checkTime(unit.courseOffer!.startDate!,unit.courseOffer!.endDate!)
         ? null 
          : CourseNavBar(
            offer: unit.courseOffer!,
            price: unit.couursePrice!,
            discountPrice: unit.courseDiscountPrice,
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                scrolledUnderElevation: 0,
                collapsedHeight: 170,
                leading: const LeadingBack(),
                flexibleSpace:VimeoPlayer(
                videoId: unit.sections![0].videos![0].vimeoId!,
              ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 7),
                      Row(
                        children: [
                           Expanded(
                            child: CourseText(
                              unit.name!,
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Column(
                            children: [
                              if(unit.discountPrice!=null)
                              CourseText(
                                "\$${unit.unitPrice}",
                                textColor: context.colorPalette.grey66,
                                decoration: TextDecoration.lineThrough,
                                fontWeight: FontWeight.bold,
                              ),
                               CourseText(
                                "\$${unit.discountPrice?? unit.unitPrice}",
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ],
                      ),
                      CourseText(
                        unit.courseName!,
                        textColor: context.colorPalette.grey66,
                        fontWeight: FontWeight.bold,
                      ),
                      StretchedButton(
                        onPressed: () {},
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                if(unit.discountPrice!=null)
                                CourseText(
                                  "\$${unit.unitPrice}",
                                  textColor: context.colorPalette.grey66,
                                  decoration: TextDecoration.lineThrough,
                                  fontWeight: FontWeight.bold,
                                ),
                                CourseText(
                                  "\$${unit.discountPrice?? unit.unitPrice}",
                                  textColor: context.colorPalette.black33,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                            CourseText(
                              context.appLocalization.subscribeToThisPartOnly,
                              fontWeight: FontWeight.bold,
                              textColor: context.colorPalette.black33,
                            ),
                            Container(
                              width: 46,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: context.colorPalette.blue8DD,
                                borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
                              ),
                              child: CourseText(
                                context.appLocalization.buying,
                                textColor: context.colorPalette.black33,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                sliver: SliverList.separated(
                  separatorBuilder: (context, index) => const SizedBox(height: 5),
                  itemCount: unit.sections!.length,
                  itemBuilder: (context, index) {
                    return  PartCard(section: unit.sections![index]);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
