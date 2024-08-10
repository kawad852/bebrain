import 'package:bebrain/alerts/feedback/app_feedback.dart';
import 'package:bebrain/model/general_model.dart';
import 'package:bebrain/network/api_service.dart';
import 'package:bebrain/providers/auth_provider.dart';
import 'package:bebrain/screens/registration/forget_password/reset_password_screen.dart';
import 'package:bebrain/screens/registration/widgets/auth_header.dart';
import 'package:bebrain/screens/registration/widgets/pincode_field.dart';
import 'package:bebrain/utils/base_extensions.dart';
import 'package:bebrain/widgets/stretch_button.dart';
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
    ApiFutureBuilder<GeneralModel>().fetch(
      context,
      future: () async {
        final otpFuture = ApiService<GeneralModel>().build(
          url: '',
          link: "https://api.doverifyit.com/api/otp-check/6879141732",
          isPublic: true,
          additionalHeaders: {
            "Authorization": "878|ddl4NYnlSKlCeYwrDtfUcTa2RNeIvdv1MPEA9rAwF3nqUxU6VIjXa4H2J9CY",
          },
          queryParams: {
            "otp": _pinCodeCtrl.text,
          },
          apiType: ApiType.post,
          builder: GeneralModel.fromJson,
        );
        return otpFuture;
      },
      onComplete: (snapshot) {
        if (snapshot.status == 200) {
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
              _userProvider.createAccount(
                context,
                phoneNum: '${widget.dialCode}${widget.phoneNum}',
                fullName: widget.fullName,
                password: widget.password,
              );
            }
          }
        } else {
          context.showSnackBar(snapshot.message ?? context.appLocalization.generalError);
        }
      },
    );
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
