import 'dart:convert';
import 'dart:math' as math;

import 'package:bebrain/alerts/feedback/app_feedback.dart';
import 'package:bebrain/alerts/loading/app_over_loader.dart';
import 'package:bebrain/helper/phone_controller.dart';
import 'package:bebrain/providers/auth_provider.dart';
import 'package:bebrain/screens/registration/create_account_screen.dart';
import 'package:bebrain/screens/registration/forget_password/forget_password_screen.dart';
import 'package:bebrain/screens/registration/widgets/auth_button.dart';
import 'package:bebrain/screens/registration/widgets/auth_header.dart';
import 'package:bebrain/screens/registration/wizard_screen.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/utils/enums.dart';
import 'package:bebrain/utils/my_icons.dart';
import 'package:bebrain/utils/my_images.dart';
import 'package:bebrain/widgets/editors/password_editor.dart';
import 'package:bebrain/widgets/phone_field.dart';
import 'package:bebrain/widgets/stretch_button.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class RegistrationScreen extends StatefulWidget {
  final bool hideGuestButton;
  const RegistrationScreen({super.key, this.hideGuestButton = false});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late PhoneController _phoneController;
  late AuthProvider _authProvider;
  final _formKey = GlobalKey<FormState>();
  String? _password;

  firebase_auth.FirebaseAuth get _firebaseAuth => firebase_auth.FirebaseAuth.instance;

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      AppOverlayLoader.show();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      if (googleAuth?.accessToken == null) {
        AppOverlayLoader.hide();
        return;
      }

      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final auth = await _firebaseAuth.signInWithCredential(credential);
      if (context.mounted) {
        await _authProvider.login(
          context,
          displayName: auth.user?.displayName,
          email: auth.user?.email,
          photoURL: auth.user?.photoURL,
        );
      }
    } on PlatformException catch (e) {
      AppOverlayLoader.hide();
      if (context.mounted) {
        if (e.code == GoogleSignIn.kNetworkError) {
          context.showSnackBar(context.appLocalization.networkError);
        } else {
          if (context.mounted) {
            context.showSnackBar(context.appLocalization.generalError);
          }
        }
      }
      debugPrint("GoogleSignInException:: $e");
    } catch (e) {
      AppOverlayLoader.hide();
      if (context.mounted) {
        context.showSnackBar(context.appLocalization.generalError);
      }
      debugPrint("GoogleSignInException:: $e");
    } finally {
      AppOverlayLoader.hide();
    }
  }

  Future<void> _signInWithApple(BuildContext context) async {
    try {
      AppOverlayLoader.show();
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final oauthCredential = firebase_auth.OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
      );

      final auth = await _firebaseAuth.signInWithCredential(oauthCredential);
      if (context.mounted) {
        await _authProvider.login(
          context,
          displayName: auth.user?.displayName,
          email: auth.user?.email,
          photoURL: auth.user?.photoURL,
        );
      }
    } on PlatformException catch (e) {
      AppOverlayLoader.hide();
      if (e.code == GoogleSignIn.kNetworkError && context.mounted) {
        context.showSnackBar(context.appLocalization.networkError, duration: 8);
      } else {
        if (context.mounted) {
          context.showSnackBar(context.appLocalization.generalError);
        }
      }
      debugPrint("AppleSignInException:: $e");
    } catch (e) {
      AppOverlayLoader.hide();
      debugPrint("AppleSignInException:: $e");
    } finally {
      AppOverlayLoader.hide();
    }
  }

  String generateNonce([int length = 32]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = math.Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  void initState() {
    super.initState();
    _authProvider = context.authProvider;
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
          if (!widget.hideGuestButton)
            TextButton(
              onPressed: () {
                context.pushAndRemoveUntil(const WizardScreen(wizardType: WizardType.countries));
              },
              child: Text(context.appLocalization.guestBrowse),
            ),
        ],
      ),
      floatingActionButton: kDebugMode
          ? FloatingActionButton(
              onPressed: () {
                context.push(
                  const WizardScreen(wizardType: WizardType.countries),
                );
              },
            )
          : null,
      bottomNavigationBar: BottomAppBar(
        child: StretchedButton(
          child: Text(context.appLocalization.login),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              FocusManager.instance.primaryFocus?.unfocus();
              _authProvider.login(
                context,
                isLogin: true,
                phoneNum: '${_phoneController.getDialCode()}${_phoneController.phoneNum}',
                password: _password!,
              );
            }
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: Image.asset(
                MyImages.logo,
                width: 100,
              ),
            ),
            const SizedBox(height: 50),
            AuthHeader(
              title: context.appLocalization.login,
              body: context.appLocalization.loginMsg,
            ),
            PhoneField(
              controller: _phoneController,
            ),
            const SizedBox(height: 15),
            PasswordEditor(
              initialValue: null,
              onChanged: (value) => _password = value,
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                onPressed: () {
                  context.push(const ForgetPasswordScreen());
                },
                style: TextButton.styleFrom(
                  foregroundColor: context.colorPalette.red232,
                ),
                child: Text(context.appLocalization.forgotPassword),
              ),
            ),
            const SizedBox(height: 49),
            AuthButton(
              onTap: () {
                context.push(const CreateAccountScreen());
              },
              icon: MyIcons.phone,
              text: context.appLocalization.conWithAPhone,
              backgroundColor: context.colorPalette.blue8DD,
              textColor: context.colorPalette.blackB0B,
              iconColor: context.colorPalette.blackB0B,
            ),
            // AuthButton(
            //   onTap: () {},
            //   icon: MyIcons.facebook,
            //   text: context.appLocalization.conWithFacebook,
            //   backgroundColor: context.colorPalette.facebook,
            //   textColor: Colors.white,
            // ),
            AuthButton(
              onTap: () {
                _signInWithGoogle(context);
              },
              icon: MyIcons.google,
              text: context.appLocalization.conWithGoogle,
              backgroundColor: context.colorPalette.greyF2F,
            ),
            AuthButton(
              onTap: () {
                _signInWithApple(context);
              },
              icon: MyIcons.apple,
              text: context.appLocalization.conWithApple,
              backgroundColor: Colors.black,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
