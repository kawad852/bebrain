import 'package:bebrain/alerts/feedback/app_feedback.dart';
import 'package:bebrain/model/auth_model.dart';
import 'package:bebrain/network/api_service.dart';
import 'package:bebrain/network/api_url.dart';
import 'package:bebrain/screens/registration/widgets/auth_header.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/widgets/editors/password_editor.dart';
import 'package:bebrain/widgets/stretch_button.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String dialCode;
  final String phoneNum;

  const ResetPasswordScreen({
    super.key,
    required this.dialCode,
    required this.phoneNum,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String? _password;
  String? _confirmPassword;
  final _formKey = GlobalKey<FormState>();

  void _onSubmit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      await ApiFutureBuilder<AuthModel>().fetch(
        context,
        future: () async {
          final resetPasswordFuture = ApiService<AuthModel>().build(
            url: ApiUrl.updatePassword,
            isPublic: true,
            apiType: ApiType.post,
            builder: AuthModel.fromJson,
            queryParams: {
              "phone_number": '${widget.dialCode}${widget.phoneNum}',
              "password": _password,
              "password_confirmation": _confirmPassword,
            },
          );
          return resetPasswordFuture;
        },
        onComplete: (value) {
          if (value.status == true) {
            context.showSnackBar(context.appLocalization.passwordUpdatedMsg);
            Navigator.popUntil(context, (route) => route.isFirst);
          } else {
            context.showSnackBar(value.msg ?? context.appLocalization.generalError);
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomAppBar(
        child: StretchedButton(
          onPressed: () {
            _onSubmit(context);
          },
          child: Text(context.appLocalization.confirm),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            AuthHeader(
              title: context.appLocalization.resetPasswordTitle,
              body: context.appLocalization.resetPasswordBody,
            ),
            const SizedBox(height: 20),
            StatefulBuilder(builder: (context, setState) {
              return ListBody(
                children: [
                  PasswordEditor(
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                      });
                    },
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
              );
            }),
          ],
        ),
      ),
    );
  }
}
