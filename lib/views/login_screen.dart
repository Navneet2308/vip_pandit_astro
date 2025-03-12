import 'package:astrologeradmin/constance/assets_path.dart';
import 'package:astrologeradmin/constance/language/language.dart';
import 'package:astrologeradmin/constance/my_colors.dart';
import 'package:astrologeradmin/constance/textstyle.dart';
import 'package:astrologeradmin/utils/function_utils.dart';
import 'package:astrologeradmin/utils/ui_utils.dart';
import 'package:astrologeradmin/views/webView/Web_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../constance/commonString.dart';
import '../constance/common_Widget.dart';
import '../provider/auth_provider.dart';
import '../widget/navigators.dart';
import 'otp_screen.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: bg,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              UiUtils.topHeaderUi(context),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 45,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      AssetsPath.logo,
                      height: 110,
                      width:
                          110, // Replace with your background image asset path
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    child: Text(
                      Languages.of(context)!.loginToAiAstrology,
                      style: mediumTextStyle(fontSize: dimen22, color: black),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    child: Text(
                      Languages.of(context)!.consultHundredsOfExpert,
                      textAlign: TextAlign.center,
                      style:
                          regularTextStyle(fontSize: dimen13, color: textHint),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: buildTextField(
                          context,
                          Languages.of(context)!.phoneNumber,
                          Languages.of(context)!.enterYourMobileNumber,
                          authProvider.updateMobile,
                          authProvider.mobile_no!!,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  GestureDetector(
                    onTap: () async {
                      if (authProvider.mobile_no!.isEmpty) {
                        showErrorSnackBar(context,
                            Languages.of(context)!.enterYourvalidMobileNumber);
                        return;
                      }
                      await authProvider.sendOtp(
                          context);
                      CustomNavigators.pushNavigate(OTPView(), context);
                    },
                    child: Container(

                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: colSecondary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          Languages.of(context)!.sendOTP,
                          style:
                              semiBoldTextStyle(fontSize: 16.0, color: white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: regularTextStyle(fontSize: 13.0, color: lightText),
                    children: [
                      TextSpan(
                        text: Languages.of(context)!.bySigningUpYouAgree,
                      ),
                      TextSpan(
                        text: " "+Languages.of(context)!.termsAndConditions,
                        style: regularTextStyle(
                            fontSize: 13.0, color: colSecondary),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => WebView(heading:Languages.of(context)!.termsAndConditions,url: termsConditions)),
                            );
                          },
                      ),
                      TextSpan(
                        text: " ${Languages.of(context)!.and} ",
                        style:
                            regularTextStyle(fontSize: 13.0, color: lightText),
                      ),
                      TextSpan(
                        text: Languages.of(context)!.privacyPolicy,
                        style: regularTextStyle(
                            fontSize: 13.0, color: colSecondary),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => WebView(heading: Languages.of(context)!.privacyPolicy,url: privacyPolicy)),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: iconUi(
                          Languages.of(context)!.privateAndConfidential,
                          AssetsPath.user)),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      flex: 1,
                      child: iconUi(Languages.of(context)!.hazzle_free_service,
                          AssetsPath.verified)),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      flex: 1,
                      child: iconUi(Languages.of(context)!.securePayments,
                          AssetsPath.card)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  iconUi(String text, String icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          icon,
          height: 45,
          width: 45,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: regularTextStyle(fontSize: 13.0, color: black),
        )
      ],
    );
  }
}
