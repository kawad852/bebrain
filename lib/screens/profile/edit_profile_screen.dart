import 'dart:io';

import 'package:bebrain/alerts/errors/app_error_feedback.dart';
import 'package:bebrain/alerts/feedback/app_feedback.dart';
import 'package:bebrain/model/auth_model.dart';
import 'package:bebrain/network/api_service.dart';
import 'package:bebrain/network/api_url.dart';
import 'package:bebrain/screens/profile/widgets/change_bubble.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_theme.dart';
import 'package:bebrain/utils/shared_pref.dart';
import 'package:bebrain/widgets/custom_network_image.dart';
import 'package:bebrain/widgets/custom_svg.dart';
import 'package:bebrain/widgets/editors/base_editor.dart';
import 'package:bebrain/widgets/editors/password_editor.dart';
import 'package:bebrain/widgets/editors/text_editor.dart';
import 'package:bebrain/widgets/stretch_button.dart';
import 'package:bebrain/widgets/titled_textfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  FilePickerResult? result;
  File? _file;
  File? imageFile;
  bool selectFile = false;
  String? currentPassword;
  String? password;
  String? passwordConfirmation;
  String? userName;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _selectFile() async {
    result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      setState(() {
        selectFile = true;
        _file = File(result!.files.single.path!);
      });
    }
  }

  void _deleteDialog(BuildContext context) {
    context.showDialog(
      titleText: context.appLocalization.deleteAccount,
      bodyText: context.appLocalization.deleteAccountMsg,
      warning: true,
    )
        .then((value) {
      if (value != null) {
        context.authProvider.deleteAccount(context);
      }
    });
  }

  void _editProfile() {
    ApiFutureBuilder<AuthModel>().fetch(
      context,
      future: () async {
        final snapshot = ApiService<AuthModel>().uploadFiles(
            url: ApiUrl.updateProfile,
            builder: AuthModel.fromJson,
            onRequest: (request) async {
              request.headers['Authorization'] = 'Bearer ${MySharedPreferences.accessToken}';
              request.headers['Content-Type'] = 'application/json';
              request.headers['x-localization'] = MySharedPreferences.language;
              if (userName != null) request.fields["name"] = userName!;
              if (currentPassword != null)  request.fields["current_password"] = currentPassword!;
              if (password != null) request.fields["password"] = password!;
              if (passwordConfirmation != null)  request.fields["password_confirmation"] = passwordConfirmation!;
              if (_file != null) {
                var file = _file;
                var stream = http.ByteStream(file!.openRead());
                var length = await file.length();
                var multipartFile = http.MultipartFile('image', stream, length,filename: file.path.split('/').last);
                request.files.add(multipartFile);
              }
            });
        return snapshot;
      },
      onComplete: (snapshot) {
        if (snapshot.code == 200) {
          context.authProvider.updateUser(context, userModel: snapshot.data!.user);
          context.pop();
          context.showSnackBar(context.appLocalization.successEditProfile);
        } else {
          context.showSnackBar(context.appLocalization.checkInfo);
        }
      },
      onError: (failure) => AppErrorFeedback.show(context, failure),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: StretchedButton(
          child: Text(context.appLocalization.save),
          onPressed: () {
            _editProfile();
          },
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
                    child: selectFile
                        ? Container(
                            width: 80,
                            height: 80,
                            alignment: Alignment.bottomCenter,
                            margin: const EdgeInsets.only(top: 25, bottom: 10),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: FileImage(_file!),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: ChangeBubble(onTap: () => _selectFile()),
                          )
                        : CustomNetworkImage(
                            context.authProvider.user.image!,
                            margin: const EdgeInsets.only(top: 25, bottom: 10),
                            width: 80,
                            height: 80,
                            clipBehavior: Clip.hardEdge,
                            alignment: Alignment.bottomCenter,
                            shape: BoxShape.circle,
                            child: ChangeBubble(onTap: () => _selectFile()),
                          ),
                  ),
                  TitledTextField(
                    title: context.appLocalization.fullName,
                    child: TextEditor(
                      hintText: context.appLocalization.enterYourNameHere,
                      initialValue: context.authProvider.user.name,
                      onChanged: (value) => value != null
                          ? userName = value.trim()
                          : userName = null,
                    ),
                  ),
                  if (context.authProvider.user.phoneNumber != null)
                    Column(
                      children: [
                        TitledTextField(
                          title: context.appLocalization.phoneNum,
                          child: BaseEditor(
                            hintText: "",
                            textDirection: TextDirection.ltr,
                            initialValue: context.authProvider.user.phoneNumber,
                            readOnly: true,
                          ),
                        ),
                        PasswordEditor(
                          title: context.appLocalization.currentPassword,
                          initialValue: null,
                          onChanged: (value) => value != null
                              ? currentPassword = value.trim()
                              : currentPassword = null,
                        ),
                        PasswordEditor(
                          title: context.appLocalization.newPassword,
                          initialValue: null,
                          onChanged: (value) => value != null
                              ? password = value.trim()
                              : password = null,
                        ),
                        PasswordEditor(
                          title: context.appLocalization.confirmNewPassword,
                          initialValue: null,
                          onChanged: (value) => value != null
                              ? passwordConfirmation = value.trim()
                              : passwordConfirmation = null,
                        ),
                      ],
                    ),
                  GestureDetector(
                    onTap: () {
                      _deleteDialog(context);
                    },
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      margin: const EdgeInsets.only(top: 25),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: context.colorPalette.greyEEE,
                        borderRadius: BorderRadius.circular(MyTheme.radiusSecondary),
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
                          ),
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
