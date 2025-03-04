import 'package:astrologeradmin/constance/assets_path.dart';
import 'package:astrologeradmin/constance/commonString.dart';
import 'package:astrologeradmin/constance/my_colors.dart';
import 'package:astrologeradmin/constance/textstyle.dart';
import 'package:astrologeradmin/utils/function_utils.dart';
import 'package:astrologeradmin/utils/ui_utils.dart';
import 'package:astrologeradmin/views/webView/Web_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';
import '../constance/language/language.dart';
import '../provider/auth_provider.dart';

class OTPView extends StatefulWidget {
  const OTPView({super.key});

  @override
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  String enteredOtp = "";

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: bg,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UiUtils.topHeaderUi(context),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      AssetsPath.logo,
                      height: 110,
                      width: 110,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    child: Text(
                      Languages.of(context)!.otpVerification,
                      style: mediumTextStyle(fontSize: dimen22, color: black),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    child: Text(
                      Languages.of(context)!.enterOtpWhichhas,
                      textAlign: TextAlign.center,
                      style:
                          regularTextStyle(fontSize: dimen13, color: lightGrey),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    child: Text(
                      authProvider.mobile_no!,
                      style: mediumTextStyle(
                          fontSize: dimen14, color: secondaryTextColor),
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 10),
                      child: OtpTextField(
                        numberOfFields: 6,
                        borderColor: secondaryTextColor,
                        focusedBorderColor: secondaryTextColor,
                        showFieldAsBox: false,
                        borderWidth: 2.0,
                        //runs when a code is typed in
                        onCodeChanged: (String code) {
                          enteredOtp = code;
                        },
                        onSubmit: (String verificationCode) {
                          enteredOtp = verificationCode;
                          print("newenteredOtp" + enteredOtp);
                        },
                      )),
                  const SizedBox(
                    height: 25,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      Languages.of(context)!.notReceivedYet,
                      style: regularTextStyle(fontSize: 14.0, color: lightText),
                    ),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                        onTap: () {
                          if (authProvider.resendTime == 0) {
                            authProvider.resendsendOtp(context);
                          }
                        },
                        child: authProvider.resendTime > 0
                            ? Text(
                                "${Languages.of(context)!.resend_in} ${authProvider.getFormattedTime()}",
                                style: mediumTextStyle(
                                  fontSize: 16.0,
                                  color: colSecondary,
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  authProvider.resendsendOtp(context);
                                },
                                child: Text(
                                  Languages.of(context)!.resend_otp,
                                  style: semiBoldTextStyle(
                                    fontSize: 16.0,
                                    color: colSecondary,
                                  ),
                                ),
                              )),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      if (enteredOtp.length == 6) {
                        await authProvider.verifyOtp(
                            authProvider.mobile_no!, enteredOtp, context);
                      } else {
                        showErrorSnackBar(context, "Please enter a valid OTP.");
                      }
                    },
                    child: Container(
                      // height: 48,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: secondaryTextColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          Languages.of(context)!.verify,
                          style:
                              semiBoldTextStyle(fontSize: 16.0, color: white),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style:
                            regularTextStyle(fontSize: 13.0, color: lightText),
                        children: [
                          TextSpan(
                            text: Languages.of(context)!.bySigningUpYouAgree,
                          ),
                          TextSpan(
                            text: Languages.of(context)!.termsAndConditions,
                            style: regularTextStyle(
                                fontSize: 13.0, color: secondaryTextColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          WebView(url: termsConditions)),
                                );
                              },
                          ),
                          TextSpan(
                            text: Languages.of(context)!.and,
                            style: regularTextStyle(
                                fontSize: 13.0, color: lightText),
                          ),
                          TextSpan(
                            text: Languages.of(context)!.privacyPolicy,
                            style: regularTextStyle(
                                fontSize: 13.0, color: secondaryTextColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          WebView(url: privacyPolicy)),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
