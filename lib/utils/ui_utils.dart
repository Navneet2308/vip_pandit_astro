import 'package:astrologeradmin/constance/commonString.dart';
import 'package:astrologeradmin/constance/language/language.dart';
import 'package:astrologeradmin/constance/textstyle.dart';
import 'package:astrologeradmin/model/consultation_response.dart';
import 'package:astrologeradmin/provider/dashboard_provider.dart';
import 'package:astrologeradmin/views/astrologer_chat/Astrologer_Chat.dart';
import 'package:astrologeradmin/views/webView/Web_view.dart';
import 'package:astrologeradmin/widget/global_button.dart';
import 'package:astrologeradmin/widget/navigators.dart';
import 'package:flutter/material.dart';

import '../constance/my_colors.dart';
import '../widget/global_bottomsheet.dart';
import '../widget/pick_your_language_bottomsheet.dart';

class UiUtils {
  static topHeaderUi(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [appTheme, darkYellow])),
          child: Text(
            Languages.of(context)!.aiAstrologyS,
            style: mediumTextStyle(fontSize: 18.0, color: white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text(
            Languages.of(context)!.findCompleteSolutionToYourProblems,
            style: mediumTextStyle(fontSize: 15.0, color: black),
          ),
        ),
      ],
    );
  }



  static callVideoCallUi(BuildContext context, Consultation consultation,
      String btn1, String btn2, Function onTap) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 10),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    color: inactive_dot_color,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        topLeft: Radius.circular(8))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 96,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 3),
                      decoration: BoxDecoration(color: yellow),
                      child: Text(
                        consultation.gender,
                        style: mediumTextStyle(fontSize: 12.0, color: black),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      consultation.fullName,
                      style: mediumTextStyle(fontSize: dimen16, color: black),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        consultation.concernTopic,
                        style:
                            regularTextStyle(fontSize: dimen14, color: black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "${Languages.of(context)!.dob}: ${consultation.dateOfBirth} ${consultation.timeOfBirth}",
                        style:
                            regularTextStyle(fontSize: dimen14, color: black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        consultation.placeOfBirth +
                            " " +
                            consultation.pincode.toString(),
                        style: mediumTextStyle(fontSize: dimen14, color: red),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(children: [
              Expanded(
                  flex: 1,
                  child: GlobalButton(btn1, red, red, () {
                    onTap("4");
                  }, 2.0, 1, mediumTextStyle(fontSize: 14.0, color: white),
                      39.0)),
              SizedBox(width: 10),
              Expanded(
                  flex: 1,
                  child: GlobalButton(btn2, colGreen, colGreen, () {
                    onTap("3");
                  }, 2.0, 1, mediumTextStyle(fontSize: 14.0, color: white),
                      39.0))
            ]),
          )
        ],
      ),
    );
  }

  static rejoinAndEndUi(BuildContext context, Consultation consultation,
      String btn1, String btn2, Function onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    color: inactive_dot_color,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        topLeft: Radius.circular(8))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 96,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 3),
                      decoration: BoxDecoration(color: yellow),
                      child: Text(
                        consultation.gender,
                        style: mediumTextStyle(fontSize: 12.0, color: black),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      consultation.fullName,
                      style: mediumTextStyle(fontSize: dimen15, color: black),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        consultation.concernTopic,
                        style:
                            regularTextStyle(fontSize: dimen13, color: black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "${Languages.of(context)!.dob}: ${consultation.dateOfBirth} ${consultation.timeOfBirth}",
                        style:
                            regularTextStyle(fontSize: dimen13, color: black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        consultation.placeOfBirth +
                            " " +
                            consultation.pincode.toString(),
                        style: mediumTextStyle(fontSize: dimen13, color: red),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(children: [
              Expanded(
                  flex: 1,
                  child: GlobalButton(btn1, red, red, () {
                    onTap("1");
                  }, 2.0, 1, mediumTextStyle(fontSize: 13.0, color: white),
                      39.0)),
              SizedBox(width: 10),
              Expanded(
                  flex: 1,
                  child: GlobalButton(btn2, colGreen, colGreen, () {
                    // Get.toNamed(Routes.astrologerChat,arguments: [consultationType,astrologer_id,astrologer_name,onValue.data,astrologer_image]);
                    onTap("3");
                  }, 2.0, 1, mediumTextStyle(fontSize: 13.0, color: white),
                      39.0))
            ]),
          )
        ],
      ),
    );
  }


  Widget menuItem1(DashboardProvider provider, BuildContext context,
      String title, IconData icon,
      {Widget? trailing}) {
    return InkWell(
      child: Container(

        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 11),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: mediumTextStyle(fontSize: dimen17, color: colBlack)),
            Container(
              child: trailing,
            ),

          ],
        ),
      ),
      onTap: () {
        final actions = {
          Languages.of(context)!.personalProfile: () => provider.changeTab(4),
          Languages.of(context)!.bankDetails: () => provider.changeTab(5),
          Languages.of(context)!.consultationSchedule: () => provider.changeTab(6),
          Languages.of(context)!.termsAndConditions: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => WebView(heading:Languages.of(context)!.termsAndConditions ,url: termsConditions)),
          ),
          Languages.of(context)!.privacyPolicies: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => WebView(heading: Languages.of(context)!.privacyPolicies,url: privacyPolicy)),
          ),
          Languages.of(context)!.refundPolicies: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => WebView(heading:Languages.of(context)!.refundPolicies ,url: refundCancellationPolicy)),
          ),
          Languages.of(context)!.aboutAiAstrology: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => WebView(heading: Languages.of(context)!.aboutAiAstrology,url: refundCancellationPolicy)),
          ),
          Languages.of(context)!.language: () => GlobalBottomSheet.show(
              context: context, child: LanguageSelectionScreen(from: "home")),
          Languages.of(context)!.my_followers: () => provider.changeTab(7),
          Languages.of(context)!.helpCenter: () => provider.changeTab(8),
          Languages.of(context)!.wallet: () => provider.changeTab(2),
          Languages.of(context)!.consultation_history: () => provider.changeTab(1),
        };

        actions.entries
            .firstWhere(
              (entry) => title==(entry.key),
          orElse: () => MapEntry("", () => {}),
        )
            .value();
      },
    );
  }

 static Widget noDataAvailableWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.info_outline, // You can change this icon as needed
            size: 50,
            color:lightText,
          ),
          SizedBox(height: 10),
          Text(
            "No Data Available",
            style: regularTextStyle(fontSize: dimen16, color: lightText),
          ),
        ],
      ),
    );
  }

  static void btnOnTap() {}


}
