import 'package:bebrain/screens/booking/widgets/previous_booking.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:bebrain/widgets/editors/base_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
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
                    context.appLocalization.appointmentsAndBookings,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      context.appLocalization.doYouNeedOnlineLecture,
                      style: TextStyle(
                        color: context.colorPalette.grey66,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  BaseEditor(
                    hintText: context.appLocalization.searchLectureName,
                    initialValue: null,
                    filled: true,
                    fillColor: context.colorPalette.white,
                    prefixIcon: const IconButton(
                      onPressed: null,
                      icon: CustomSvg(MyIcons.search),
                    ),
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            sliver: SliverToBoxAdapter(
              child: ShrinkWrappingViewport(
                offset: ViewportOffset.zero(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.appLocalization.previousBookings,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  SliverList.separated(
                    separatorBuilder: (context, index) => const SizedBox(height: 5),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return const PreviousBooking();
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
