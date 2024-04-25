import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/titled_textfield.dart';
import 'package:flutter/material.dart';

class SendRequestScreen extends StatefulWidget {
  const SendRequestScreen({super.key});

  @override
  State<SendRequestScreen> createState() => _SendRequestScreenState();
}

class _SendRequestScreenState extends State<SendRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(pinned: true),
            SliverToBoxAdapter(
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
                      context
                          .appLocalization.requestSolveAssignmentAndSendRequest,
                      style: TextStyle(
                        color: context.colorPalette.grey66,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  TitledTextField(
                    title: context.appLocalization.country,
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(MyTheme.radiusSecondary),
                        border: Border.all(
                          color: context.colorPalette.greyF2F,
                        ),
                      ),
                      child: DropdownMenu(
                        hintText: context.appLocalization.selectCountry,
                        textStyle: TextStyle(
                          color: context.colorPalette.grey66,
                          fontSize: 14,
                        ),
                        expandedInsets: EdgeInsets.zero,
                        inputDecorationTheme: const InputDecorationTheme(
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                        dropdownMenuEntries: const <DropdownMenuEntry<String>>[
                          DropdownMenuEntry(value: "Syria", label: "Syria"),
                          DropdownMenuEntry(value: "Jordon", label: "Jordon"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
