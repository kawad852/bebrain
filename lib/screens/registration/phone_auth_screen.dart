import 'package:bebrain/helper/phone_controller.dart';
import 'package:bebrain/screens/registration/widgets/auth_header.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/widgets/phone_field.dart';
import 'package:bebrain/widgets/stretch_button.dart';
import 'package:flutter/material.dart';

class PhoneAuthScreen extends StatefulWidget {
  final String? email, fullName, photoURL;

  const PhoneAuthScreen({
    super.key,
    required this.email,
    this.fullName,
    this.photoURL,
  });

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final _formKey = GlobalKey<FormState>();
  late PhoneController _phoneController;

  Future<void> _onSubmit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      context.authProvider.sendPinCode(
        context,
        dialCode: _phoneController.getDialCode(),
        phoneNum: _phoneController.phoneNum!,
        fullName: widget.fullName,
        email: widget.email,
        photoURL: widget.photoURL,
        socialLogin: true,
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
          child: Text(context.appLocalization.next),
          onPressed: () {
            _onSubmit(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AuthHeader(
                title: context.appLocalization.phoneNum,
                body: context.appLocalization.phoneNumBody,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: PhoneField(
                  controller: _phoneController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
