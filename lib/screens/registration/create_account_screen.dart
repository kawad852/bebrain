import 'package:bebrain/helper/phone_controller.dart';
import 'package:bebrain/screens/registration/widgets/auth_header.dart';
import 'package:bebrain/screens/registration/wizard_screen.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/enums.dart';
import 'package:bebrain/widgets/editors/password_editor.dart';
import 'package:bebrain/widgets/editors/text_editor.dart';
import 'package:bebrain/widgets/phone_field.dart';
import 'package:bebrain/widgets/stretch_button.dart';
import 'package:bebrain/widgets/titled_textfield.dart';
import 'package:flutter/material.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({
    super.key,
  });

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  String? _fullName;
  String? _password;
  String? _confirmPassword;
  final _formKey = GlobalKey<FormState>();
  late PhoneController _phoneController;

  Future<void> _onSubmit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      context.authProvider.sendPinCode(
        context,
        dialCode: _phoneController.getDialCode(),
        phoneNum: _phoneController.phoneNum!,
        password: _password!,
        fullName: _fullName!,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(const WizardScreen(wizardType: WizardType.countries));
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: StretchedButton(
          child: Text(context.appLocalization.next),
          onPressed: () {
            _onSubmit(context);
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(30),
          children: [
            AuthHeader(
              title: context.appLocalization.createAccount,
              body: context.appLocalization.createAccountMsg,
            ),
            TitledTextField(
              title: context.appLocalization.fullName,
              child: TextEditor(
                initialValue: _fullName,
                hintText: context.appLocalization.fullNameHint,
                onChanged: (value) => _fullName = value,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: PhoneField(
                controller: _phoneController,
              ),
            ),
            PasswordEditor(
              onChanged: (value) => _password = value,
              initialValue: null,
            ),
            const SizedBox(height: 24),
            PasswordEditor(
              onChanged: (value) => _confirmPassword = value,
              isConfirm: true,
              password: _password,
              initialValue: null,
            ),
          ],
        ),
      ),
    );
  }
}
