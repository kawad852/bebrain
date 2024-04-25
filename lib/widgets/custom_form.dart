import 'package:bebrain/screens/send_request/send_request_screen.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:bebrain/widgets/previous_request.dart';
import 'package:bebrain/widgets/stretch_button.dart';
import 'package:flutter/material.dart';

class CustomForm extends StatefulWidget {
  final String title;
  final String description;
  final bool isGraduationProjects;
  const CustomForm({
    super.key,
    required this.title,
    required this.description,
    this.isGraduationProjects = false,
  });

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 15),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.only(top: 25, bottom: 5),
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      widget.description,
                      style: TextStyle(
                        color: context.colorPalette.grey66,
                        fontSize: 14,
                      ),
                    ),
                    StretchedButton(
                      onPressed: () {
                        context.push(const SendRequestScreen());
                      },
                      margin:
                          const EdgeInsetsDirectional.only(top: 25, bottom: 10),
                      child: Row(
                        children: [
                          const CustomSvg(MyIcons.message),
                          const Expanded(child: SizedBox.shrink()),
                          Text(
                            widget.isGraduationProjects
                                ? context.appLocalization.projectRequest
                                : context.appLocalization.sendNewRequest,
                            style: TextStyle(
                              fontSize: 16,
                              color: context.colorPalette.black33,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Expanded(child: SizedBox.shrink()),
                        ],
                      ),
                    ),
                    Text(
                      context.appLocalization.previousRequests,
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
                  return const PreviousRequest();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
