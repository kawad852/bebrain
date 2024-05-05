import 'package:bebrain/helper/phone_controller.dart';
import 'package:bebrain/screens/registration/widgets/auth_button.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_images.dart';
import 'package:bebrain/widgets/editors/password_editor.dart';
import 'package:bebrain/widgets/phone_field.dart';
import 'package:bebrain/widgets/stretch_button.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(context.appLocalization.guestBrowse),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: StretchedButton(
          child: Text(context.appLocalization.login),
          onPressed: () {},
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Image.asset(
              MyImages.logo,
            ),
          ),
          const SizedBox(height: 50),
          Text(
            context.appLocalization.login,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(top: 6, bottom: 30),
            child: Text(
              context.appLocalization.loginMsg,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          PhoneField(
            controller: _phoneController,
          ),
          const SizedBox(height: 15),
          PasswordEditor(
            initialValue: null,
            onChanged: (value) {},
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: context.colorPalette.red232,
              ),
              child: Text(context.appLocalization.forgotPassword),
            ),
          ),
          const SizedBox(height: 49),
          AuthButton(
            onTap: () {},
            icon: MyIcons.facebook,
            text: context.appLocalization.conWithFacebook,
            backgroundColor: context.colorPalette.facebook,
            textColor: Colors.white,
          ),
          AuthButton(
            onTap: () {},
            icon: MyIcons.google,
            text: context.appLocalization.conWithGoogle,
            backgroundColor: context.colorPalette.greyF2F,
          ),
          AuthButton(
            onTap: () {},
            icon: MyIcons.apple,
            text: context.appLocalization.conWithApple,
            backgroundColor: Colors.black,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}