import 'package:bebrain/model/slider_model.dart';
import 'package:bebrain/screens/course/course_screen.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_network_image.dart';
import 'package:bebrain/widgets/custom_smoth_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MySlider extends StatefulWidget {
  final List<SliderData> slider;
  const MySlider({super.key,required this.slider});

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.slider.length,
          options: CarouselOptions(
            viewportFraction: 1,
            enableInfiniteScroll: false,
            height: context.mediaQuery.height * 0.28,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
          itemBuilder: (context, index, realIndex) {
            return CustomNetworkImage(
              widget.slider[index].image!,
              width: double.infinity,
              height: 130,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              radius: MyTheme.radiusSecondary,
              onTap: (){
                if(widget.slider[index].courseId != null){
                  context.authProvider.checkIfUserAuthenticated(context,
                        callback: () {
                      context.push(CourseScreen(courseId: widget.slider[index].courseId!));
                    });
                }
              },
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: CustomSmoothIndicator(
              count: widget.slider.length,
              index: currentIndex,
            ),
          ),
        ),
      ],
    );
  }
}
