import 'package:astrologeradmin/constance/assets_path.dart';
import 'package:astrologeradmin/constance/my_colors.dart';
import 'package:astrologeradmin/constance/textstyle.dart';
import 'package:astrologeradmin/utils/ui_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../constance/language/language.dart';


class RegisterSuccessScreen extends StatelessWidget {
  const RegisterSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:bg,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            UiUtils.topHeaderUi(context),
            SizedBox(height: 80,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:20.0),
              child: Column(
                children: [
                  SvgPicture.asset(AssetsPath.warningCircle,height: 150,width: 150),

                  SizedBox(height:15,),
                  Text(
                    textAlign: TextAlign.center,
                    "${Languages.of(context)!.account_under_Review}",
                    style: mediumTextStyle(
                        fontSize: dimen22, color: black),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    "${Languages.of(context)!.welcome_to_aiAstro}",
                    style: regularTextStyle(
                        fontSize: dimen13, color:textHint),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                 /* GestureDetector(
                    onTap: () {
                   //   Get.offNamed(Routes.registerSuccessScreen);
                    },
                    child: Container(
                      height:48,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color:appTheme,
                          borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Continue",
                          style: semiBoldTextStyle(
                              fontSize: 16.0, color:white),
                        ),
                      ),
                    ),
                  )*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



