import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constance/assets_path.dart';
import '../constance/language/language.dart';
import '../constance/my_colors.dart';
import '../constance/textstyle.dart';
import '../model/update_consultationModel.dart';
import '../utils/ui_utils.dart';
import '../widget/global_bottomsheet.dart';
import '../widget/pick_your_language_bottomsheet.dart';

class ConsultationComplete extends StatefulWidget {

  final ConsultationData? mconsultationData;

  ConsultationComplete({required this.mconsultationData});
  @override
  State<ConsultationComplete> createState() => _ConsultationCompleteState();
}

class _ConsultationCompleteState extends State<ConsultationComplete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colPrimary,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Image.asset(
            AssetsPath.logo,
            height: 40.0,
            width: 40.0,
          ),
        ),
        title: Text(
          Languages.of(context)!.aiAstrologyS,
          style: semiBoldTextStyle(fontSize: dimen16, color: black),
        ),
        actions: [
          InkWell(
              onTap: () {
                // provider.changeTab(8);
              },
              child: Image.asset(
                AssetsPath.headPhone,
                height: 35,
                width: 35,
              )),
          SizedBox(
            width: 10,
          ),
          InkWell(
              onTap: (){
                GlobalBottomSheet.show(context: context, child:LanguageSelectionScreen(from: "home"));
              },
              child: Image.asset(AssetsPath.language, height: 35, width: 35)),
          SizedBox(width: 15),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 50,),
              Column(
                children: [
                  Lottie.asset(AssetsPath.checkAnim, height: 150, width: 150),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      textAlign: TextAlign.center,
                      "Consultation Completed", // Localized string
                      style: mediumTextStyle(
                          fontSize: dimen24, color: colBlack),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      textAlign: TextAlign.center,
                     "Your consultation completed", // Localized string
                      style: regularTextStyle(
                          fontSize: dimen14, color:colHint),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${widget.mconsultationData!.duration} Minutes | ${widget.mconsultationData!.consultationType=="2"?"Audio/Video Consultation":"Chat Consultation"}",style: semiBoldTextStyle(fontSize: dimen14, color: colBlack),)
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      textAlign: TextAlign.center,
                      "₹ ${widget.mconsultationData!.chargeAmount}", // Localized string
                      style: boldTextStyle(
                          fontSize: dimen24, color: colBlack),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      textAlign: TextAlign.center,
                      "Earned from this consultation & transferred to wallet", // Localized string
                      style: regularTextStyle(
                          fontSize: dimen14, color: colHint),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),


                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 48,
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
                          "Continue", // Localized string
                          style: semiBoldTextStyle(
                              fontSize: 16.0, color: colWhite),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 60,),

                ],
              ),
            ],
          ),
        ),
      ),
    );

  }
}
