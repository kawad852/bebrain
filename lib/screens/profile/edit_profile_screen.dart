import 'package:bebrain/helper/phone_controller.dart';
import 'package:bebrain/utils/app_constants.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/widgets/custom_network_image.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:bebrain/widgets/editors/base_editor.dart';
import 'package:bebrain/widgets/editors/password_editor.dart';
import 'package:bebrain/widgets/phone_field.dart';
import 'package:bebrain/widgets/stretch_button.dart';
import 'package:bebrain/widgets/titled_textfield.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late PhoneController _phoneController;

  @override
  void initState() {
    super.initState();
    _phoneController = PhoneController(context);
  }

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: StretchedButton(
          child: Text(context.appLocalization.save),
          onPressed: () {},
        ),
      ),
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
                    context.appLocalization.editProfile,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Center(
                    child: CustomNetworkImage(
                      kFakeImage,
                      margin: const EdgeInsets.only(top: 25, bottom: 10),
                      width: 80,
                      height: 80,
                      clipBehavior: Clip.hardEdge,
                      alignment: Alignment.bottomCenter,
                      shape: BoxShape.circle,
                      child: Container(
                        width: double.infinity,
                        height: 20,
                        alignment: Alignment.center,
                        color: context.colorPalette.blue8DD,
                        child: Text(
                          context.appLocalization.edit,
                          style: TextStyle(
                            color: context.colorPalette.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  TitledTextField(
                    title: context.appLocalization.fullName,
                    child: BaseEditor(
                      hintText: context.appLocalization.enterYourNameHere,
                      initialValue: null,
                      onChanged: (value) {},
                    ),
                  ),
                  PhoneField(
                    controller: _phoneController,
                  ),
                  PasswordEditor(
                    title: context.appLocalization.currentPassword,
                    initialValue: null,
                    onChanged: (value) {},
                  ),
                  PasswordEditor(
                    title: context.appLocalization.newPassword,
                    initialValue: null,
                    onChanged: (value) {},
                  ),
                  PasswordEditor(
                    title: context.appLocalization.confirmNewPassword,
                    initialValue: null,
                    onChanged: (value) {},
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      margin: const EdgeInsets.only(top: 25),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: context.colorPalette.greyEEE,
                        borderRadius:
                            BorderRadius.circular(MyTheme.radiusSecondary),
                      ),
                      child: Row(
                        children: [
                          const CustomSvg(MyIcons.deleteAccount),
                          const SizedBox(width: 8),
                          Text(
                            context.appLocalization.deleteAccount,
                            style: TextStyle(
                              color: context.colorPalette.redE66,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
