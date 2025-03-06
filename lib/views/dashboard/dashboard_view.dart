import 'dart:io';

import 'package:astrologeradmin/constance/assets_path.dart';
import 'package:astrologeradmin/constance/language/language.dart';
import 'package:astrologeradmin/constance/my_colors.dart';
import 'package:astrologeradmin/constance/textstyle.dart';
import 'package:astrologeradmin/provider/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../widget/global_bottomsheet.dart';
import '../../widget/pick_your_language_bottomsheet.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget bottomNavigationBar(DashboardProvider provider) {
    return Container(
        height: 60,
        child: BottomNavigationBar(
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          backgroundColor: white,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(provider.iconList[0],
                  height: 18,
                  width: 18,
                  color: provider.tabIndex == 0 ? colSecondary : lightText),
              label: provider.titleList[0],
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(provider.iconList[1],
                  height: 18,
                  width: 18,
                  color: provider.tabIndex == 1 ? colSecondary : lightText),
              label: provider.titleList[1],
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(provider.iconList[2],
                  height: 18,
                  width: 18,
                  color: provider.tabIndex == 2 ? colSecondary : lightText),
              label: provider.titleList[2],
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                provider.iconList[3],
                height: 18,
                width: 18,
                color: (provider.tabIndex == 3 ||
                        provider.tabIndex == 4 ||
                        provider.tabIndex == 5 ||
                        provider.tabIndex == 6 ||
                        provider.tabIndex == 7 ||
                        provider.tabIndex == 8)
                    ? colSecondary
                    : lightText,
              ),
              label: provider.titleList[3],
            ),
          ],
          iconSize: 18,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          currentIndex: provider.tabIndex > 3 ? 3 : provider.tabIndex,
          selectedItemColor: secondaryTextColor,
          unselectedItemColor: lightText,
          onTap: (int index) {
            provider.tabOnTap(index);
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, provider, child) {
      return Scaffold(
          backgroundColor: bg,
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
                    provider.changeTab(8);
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
          body:
          PopScope(
            canPop: false,
            onPopInvoked: (didPop) async {
              if(provider.tabIndex>3)
                {
                  provider.changeTab(provider.previous_tab);
                }
              else
                {
              if (provider.titleList[provider.tabIndex].toString() == "Home") {
                showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(Languages.of(context)!.exitAppTitle), // Localized title
                    content: Text(Languages.of(context)!.exitAppMessage), // Localized message
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Text(
                          Languages.of(context)!.no, // Localized "No"
                          style: mediumTextStyle(
                              fontSize: dimen16, color: colSecondary),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          exit(0);
                        },
                        child: Text(
                          Languages.of(context)!.yes, // Localized "Yes"
                          style: mediumTextStyle(
                              fontSize: dimen16, color:colSecondary),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                provider.changeTab(0);
                // pro.currentIndex.value = 0;
                // controller.selectedWidget.value = HomeView();
              }}

              // logic
            },
            child: Consumer<DashboardProvider>(builder: (context, provider, child) {
                            return provider.pagesList[provider.tabIndex];
                          }),
              ),
          bottomNavigationBar:
              Consumer<DashboardProvider>(builder: (context, provider, child) {
            return bottomNavigationBar(provider);
          }));
    });
  }
}
