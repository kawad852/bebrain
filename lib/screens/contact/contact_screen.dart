import 'dart:convert';

import 'package:bebrain/alerts/feedback/app_feedback.dart';
import 'package:bebrain/alerts/loading/app_over_loader.dart';
import 'package:bebrain/helper/validation_helper.dart';
import 'package:bebrain/providers/auth_provider.dart';
import 'package:bebrain/screens/contact/widgets/contact_nav_bar.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/enums.dart';
import 'package:bebrain/widgets/editors/base_editor.dart';
import 'package:http/http.dart' as http;
import 'package:bebrain/widgets/stretch_button.dart';
import 'package:bebrain/widgets/titled_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  late TextEditingController nameCtrl, subjectCtrl, msgCtrl, emailCtrl;
  late AuthProvider authProvider;
  final _formKey = GlobalKey<FormState>();

  Future<void> _sendEmail(BuildContext context) async {
    try {
      AppOverlayLoader.show();
      const url = 'https://api.emailjs.com/api/v1.0/email/send';
      Uri uri = Uri.parse(url);
      var headers = {
        'Content-Type': 'application/json',
        'origin': 'http://localhost',
      };
      var body = jsonEncode({
        'service_id': EmailJsEnum.serviceId,
        'template_id': EmailJsEnum.templateId,
        'user_id': EmailJsEnum.userId,
        'template_params': {
          'user_name': nameCtrl.text,
          'user_email': emailCtrl.text,
          'user_subject': subjectCtrl.text,
          'user_message': msgCtrl.text,
        },
      });
      debugPrint("Response:: CheckoutResponse\nUrl:: $url\nheaders:: ${headers.toString()}");
      http.Response response = await http.post(uri, headers: headers, body: body);
      debugPrint("CheckoutStatusCode:: ${response.statusCode} CheckoutBody:: ${response.body}");
      AppOverlayLoader.hide();
      if (response.statusCode == 200) {
        if (context.mounted) {
          context.showSnackBar(context.appLocalization.msgSendSuccessfully);
          Navigator.pop(context);
        }
      } else {
        if (context.mounted) {
          context.showSnackBar(context.appLocalization.generalError);
        }
      }
    } catch (e) {
      debugPrint("$e");
      AppOverlayLoader.hide();
      if (context.mounted) {
        context.showSnackBar(context.appLocalization.generalError);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    nameCtrl = TextEditingController(text: authProvider.user.name ?? "");
    subjectCtrl = TextEditingController();
    msgCtrl = TextEditingController();
    emailCtrl = TextEditingController(text: authProvider.user.email ?? "");
  }

  @override
  void dispose() {
    super.dispose();
    nameCtrl.dispose();
    subjectCtrl.dispose();
    msgCtrl.dispose();
    emailCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:const ContactNavBar(),
      body: Form(
        key: _formKey,
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(pinned: true),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.appLocalization.contactAlmusaed,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        context.appLocalization.contactDiscription,
                        style: TextStyle(
                          color: context.colorPalette.grey66,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    TitledTextField(
                      title: context.appLocalization.fullName,
                      child: BaseEditor(
                        controller: nameCtrl,
                        hintText: context.appLocalization.fullNameHint,
                        validator: (value) {
                          return ValidationHelper.general(context, value);
                        },
                      ),
                    ),
                    TitledTextField(
                      title: context.appLocalization.phoneNum,
                      child: BaseEditor(
                        hintText: "",
                        textDirection: TextDirection.ltr,
                        initialValue: authProvider.user.phoneNumber,
                        readOnly: true,
                       ),
                     ),
                    TitledTextField(
                      title: context.appLocalization.yourEmail,
                      child: BaseEditor(
                        controller: emailCtrl,
                        keyboardType: TextInputType.emailAddress,
                        hintText: context.appLocalization.emailHint,
                        validator: (value) {
                          return ValidationHelper.email(context, value);
                        },
                      ),
                    ),
                    TitledTextField(
                      title: context.appLocalization.title,
                      child: BaseEditor(
                        controller: subjectCtrl,
                        hintText: context.appLocalization.titleHint,
                        validator: (value) {
                          return ValidationHelper.general(context, value);
                        },
                      ),
                    ),
                    TitledTextField(
                      title: context.appLocalization.notes,
                      child: BaseEditor(
                        controller: msgCtrl,
                        maxLines: 4,
                        hintText: context.appLocalization.notesHint,
                        validator: (value) {
                           return ValidationHelper.general(context, value);
                        },
                      ),
                    ),
                    StretchedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()){
                          FocusManager.instance.primaryFocus?.unfocus();
                          _sendEmail(context);
                        }
                      },
                      child: Text(
                        context.appLocalization.send,
                        style: TextStyle(
                          color: context.colorPalette.black33,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
