import 'package:astrologeradmin/constance/assets_path.dart';
import 'package:astrologeradmin/constance/language/language.dart';
import 'package:astrologeradmin/constance/my_colors.dart';
import 'package:astrologeradmin/constance/textstyle.dart';
import 'package:astrologeradmin/utils/ui_utils.dart';
import 'package:astrologeradmin/widget/global_bottomsheet.dart';
import 'package:astrologeradmin/widget/global_button.dart';
import 'package:astrologeradmin/widget/pick_your_language_bottomsheet.dart';
import 'package:flutter/material.dart';

class IntroView extends StatelessWidget {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: bg,
     
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UiUtils.topHeaderUi(context),

              
              Padding(
                padding: const EdgeInsets.only(top:45.0),
                child: Image.asset(AssetsPath.womanAstrologer,height: 279,width: 428,),
              ),
        
        
                Padding(
                  padding: const EdgeInsets.only(left:20.0,right: 20,top:20),
                  child: Text(Languages.of(context)!.exploreNowToExperience,textAlign: TextAlign.center,style:mediumTextStyle(fontSize:22.0, color:black),),
                ),
        
        
              Padding(
                padding: const EdgeInsets.only(top: 15.0,left: 20,right: 20),
                child: Text(Languages.of(context)!.onbord_des,textAlign: TextAlign.center,style:regularTextStyle(fontSize:12.0, color:lightText),),
              ),
        
        
              SizedBox(height:80,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:20.0),
                child: GlobalButton(Languages.of(context)!.getStarted,red, red,(){
        
                  GlobalBottomSheet.show(context: context, child:LanguageSelectionScreen(from: "intro"));
        
                },8,1,mediumTextStyle(fontSize:dimen16, color:white),43.0),
              )
            ],
          ),
        ),
      ),
    );
  }

}
