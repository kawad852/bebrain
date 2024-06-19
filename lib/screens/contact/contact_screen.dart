import 'package:bebrain/helper/phone_controller.dart';
import 'package:bebrain/screens/contact/widgets/contact_nav_bar.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/shared_pref.dart';
import 'package:bebrain/widgets/editors/text_editor.dart';
import 'package:bebrain/widgets/phone_field.dart';
import 'package:bebrain/widgets/stretch_button.dart';
import 'package:bebrain/widgets/titled_textfield.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  late PhoneController _phoneController;
  final _formKey = GlobalKey<FormState>();
  String? _name = MySharedPreferences.user.name ?? "";
  String? _email = MySharedPreferences.user.email ?? "";
  String? _title;
  String? _notes;

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
                      child: TextEditor(
                        initialValue: _name,
                        hintText: context.appLocalization.fullNameHint,
                        onChanged: (value) => _name = value,
                      ),
                    ),
                    PhoneField(
                      controller: _phoneController,
                    ),
                    TitledTextField(
                      title: context.appLocalization.yourEmail,
                      child: TextEditor(
                        initialValue: _email,
                        keyboardType: TextInputType.emailAddress,
                        hintText: context.appLocalization.emailHint,
                        onChanged: (value) => _email = value,
                      ),
                    ),
                    TitledTextField(
                      title: context.appLocalization.title,
                      child: TextEditor(
                        initialValue: _title,
                        hintText: context.appLocalization.titleHint,
                        onChanged: (value) => _title = value,
                      ),
                    ),
                    TitledTextField(
                      title: context.appLocalization.notes,
                      child: TextEditor(
                        initialValue: _notes,
                        maxLines: 4,
                        hintText: context.appLocalization.notesHint,
                        onChanged: (value) => _notes = value,
                      ),
                    ),
                    StretchedButton(
                      onPressed: () {},
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
