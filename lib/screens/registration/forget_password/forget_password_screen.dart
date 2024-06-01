import 'package:bebrain/helper/phone_controller.dart';
import 'package:bebrain/screens/registration/widgets/auth_header.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/widgets/phone_field.dart';
import 'package:bebrain/widgets/stretch_button.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late PhoneController _phoneController;

  void _onNext() {
    if (_formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      context.authProvider.sendPinCode(
        context,
        dialCode: _phoneController.getDialCode(),
        phoneNum: _phoneController.phoneNum!,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _phoneController = PhoneController(context);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomAppBar(
        child: StretchedButton(
          onPressed: () {
            _onNext();
          },
          child: Text(context.appLocalization.next),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AuthHeader(
                title: context.appLocalization.forgetPasswordTitle,
                body: context.appLocalization.forgetPasswordBody,
              ),
              const SizedBox(height: 20),
              PhoneField(
                controller: _phoneController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
