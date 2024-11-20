import 'package:bebrain/screens/registration/widgets/auth_header.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/widgets/editors/text_editor.dart';
import 'package:bebrain/widgets/stretch_button.dart';
import 'package:bebrain/widgets/titled_textfield.dart';
import 'package:flutter/material.dart';

class CreateAccountScreen extends StatefulWidget {
  final String dialCode;
  final String phoneNum;

  const CreateAccountScreen({
    super.key,
    required this.dialCode,
    required this.phoneNum,
  });

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  String? _fullName;
  final _formKey = GlobalKey<FormState>();

  Future<void> _onSubmit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      context.authProvider.createAccount(
        context,
        fullName: _fullName,
        phoneNum: "${widget.dialCode}${widget.phoneNum}",
      );
    }
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
          ],
        ),
      ),
    );
  }
}
