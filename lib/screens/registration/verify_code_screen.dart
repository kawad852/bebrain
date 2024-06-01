import 'package:bebrain/alerts/feedback/app_feedback.dart';
import 'package:bebrain/alerts/loading/app_over_loader.dart';
import 'package:bebrain/providers/auth_provider.dart';
import 'package:bebrain/screens/registration/forget_password/reset_password_screen.dart';
import 'package:bebrain/screens/registration/widgets/auth_header.dart';
import 'package:bebrain/screens/registration/widgets/pincode_field.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/widgets/stretch_button.dart';
import 'package:firebase_auth/firebase_auth.dart' as fire_auth;
import 'package:flutter/material.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String dialCode;
  final String phoneNum;
  final String? password;
  final String? fullName;
  final String verificationId;
  final String? guestRoute;

  const VerifyCodeScreen({
    super.key,
    required this.verificationId,
    required this.dialCode,
    required this.phoneNum,
    required this.guestRoute,
    required this.password,
    required this.fullName,
  });

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  late TextEditingController _pinCodeCtrl;
  late String _verificationId;
  late AuthProvider _userProvider;

  Future<void> _verifyPinCode(BuildContext context) async {
    try {
      AppOverlayLoader.show();
      fire_auth.PhoneAuthCredential credential = fire_auth.PhoneAuthProvider.credential(verificationId: _verificationId, smsCode: _pinCodeCtrl.text);
      final auth = await fire_auth.FirebaseAuth.instance.signInWithCredential(credential);
      if (widget.password == null) {
        if (context.mounted) {
          context.push(
            ResetPasswordScreen(
              dialCode: widget.dialCode,
              phoneNum: widget.phoneNum,
            ),
          );
        }
      } else {
        if (context.mounted) {
          await _userProvider.createAccount(
            context,
            phoneNum: '${widget.dialCode}${widget.phoneNum}',
            fullName: widget.fullName,
            password: widget.password,
          );
        }
      }
    } on fire_auth.FirebaseAuthException catch (e) {
      AppOverlayLoader.hide();
      if (context.mounted && e.code == 'invalid-verification-code') {
        context.showSnackBar(context.appLocalization.invalidPhoneCode);
      } else if (context.mounted && e.code == 'session-expired') {
        context.showSnackBar(context.appLocalization.codeExpired);
      } else {
        if (context.mounted) {
          context.showSnackBar(context.appLocalization.generalError);
        }
      }
    } catch (e) {
      debugPrint("VerifyPinCodeError:: $e");
      AppOverlayLoader.hide();
      if (context.mounted) {
        context.showSnackBar(context.appLocalization.generalError);
      }
    } finally {
      AppOverlayLoader.hide();
    }
  }

  void _onResend() {
    _userProvider.sendPinCode(
      context,
      dialCode: widget.dialCode,
      phoneNum: widget.phoneNum,
      fullName: widget.fullName,
      password: widget.password,
      onResent: (id) {
        _pinCodeCtrl.clear();
        _verificationId = id;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _userProvider = context.authProvider;
    _pinCodeCtrl = TextEditingController();
    _verificationId = widget.verificationId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomAppBar(
        child: StretchedButton(
          onPressed: () {
            if (_pinCodeCtrl.text.length < 6) {
              context.showSnackBar(context.appLocalization.enterPhoneCode);
              return;
            }
            _verifyPinCode(context);
          },
          child: Text(context.appLocalization.next),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          AuthHeader(
            title: context.appLocalization.verifyPhoneNum,
            body: context.appLocalization.verifyCodeMsg,
          ),
          PinCodeField(
            controller: _pinCodeCtrl,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(context.appLocalization.noPinReceived),
              const SizedBox(width: 5),
              Material(
                child: InkWell(
                  onTap: () {
                    _onResend();
                  },
                  child: Row(
                    children: [
                      Text(context.appLocalization.resend),
                      const SizedBox(width: 5),
                      const Icon(Icons.restart_alt),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
