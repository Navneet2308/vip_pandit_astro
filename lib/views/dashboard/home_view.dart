import 'package:astrologeradmin/constance/language/language.dart';
import 'package:astrologeradmin/constance/textstyle.dart';
import 'package:astrologeradmin/utils/ui_utils.dart';
import 'package:astrologeradmin/widget/global_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';

import '../../constance/CustomSwitch.dart';
import '../../constance/my_colors.dart';
import '../../model/consultation_response.dart';
import '../../provider/dashboard_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<DashboardProvider>(context, listen: false);
      provider.setDataOnCardList(context);
      provider.getDeatils(context);
      provider.fetchLanguageData();
      provider.fetchCategory();
      provider.fetchSkills();
      provider.getDutyStatus(context);
      provider.getBankAccountAPI(context);
      provider.getBankDetails();
    });
    return Consumer<DashboardProvider>(builder: (context, provider, child) {
      return Scaffold(
        backgroundColor: bg,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              !provider.is_Consultation_Schedule
                  ? Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: pich,
                      ),
                      child: Text(
                        Languages.of(context)!.consultationScheduleNotUpdated,
                        style: mediumTextStyle(fontSize: dimen15, color: black),
                      ),
                    )
                  : Container(),
              Container(
                padding: EdgeInsets.fromLTRB(dimen15, dimen15, dimen15, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Languages.of(context)!.welcome +
                                " Mr. ${provider.username} Ji",
                            style: mediumTextStyle(
                                fontSize: dimen18, color: black),
                          ),
                          SizedBox(height: 3),
                          Text(
                            Languages.of(context)!.start_solving_people_problem,
                            style: regularTextStyle(
                                fontSize: dimen13, color: lightGrey),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: dimen20),
                    provider.dutyStatus == "True"
                        ? Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: [
                                  BoxShadow(blurRadius: 1, color: lightText)
                                ]),
                            child: Column(
                              children: [
                                Text(
                                  Languages.of(context)!.dutyOnOff,
                                  style: mediumTextStyle(
                                      fontSize: 11.0, color: black),
                                ),
                                SizedBox(height: 4),
                                CustomSwitch(
                                  value: provider.is_duty_on,
                                  activeText: "ON",
                                  inactiveText: "OFF",
                                  textSize: dimen12,
                                  onToggle: (val) {
                                    provider.dutyToggle(context, val);
                                  },
                                )
                              ],
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: dimen15),
                child: Consumer<DashboardProvider>(
                    builder: (context, provider, child) {
                  return image_slider(provider);
                }),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: ResponsiveGridRow(
                    children: List.generate(provider.heading_data.length,
                        (int index) {
                  return ResponsiveGridCol(
                    xs: 6,
                    md: 3,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                      alignment: Alignment(0, 0),
                      decoration: BoxDecoration(
                          color: lightYellow,
                          border: Border.all(color: yellow, width: 1),
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            provider.value_data[index],
                            style: semiBoldTextStyle(
                                fontSize: dimen17, color: black),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            provider.heading_data[index],
                            style:
                                regularTextStyle(fontSize: dimen12, color: red),
                          ),
                        ],
                      ),
                    ),
                  );
                })),
              ),
              provider.activeconsultationList.length > 0
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: dimen15, vertical: dimen14),
                          child: Text(
                            Languages.of(context)!.activeConsultation,
                            style: semiBoldTextStyle(
                                fontSize: dimen15, color: black),
                          ),
                        ),
                        ListView.builder(
                            itemCount: provider.activeconsultationList.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, int index) {
                              return Container(
                                margin: EdgeInsets.only(left: 15,right: 15,bottom: 15),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.0),
                                    boxShadow: [
                                      BoxShadow(blurRadius: 2, color: lightText)
                                    ]),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 7, horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: blue,
                                          borderRadius: BorderRadius.only(
                                              topRight:
                                                  Radius.circular(dimen12),
                                              topLeft:
                                                  Radius.circular(dimen12))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            Languages.of(context)!
                                                .audioVideoCall,
                                            style: mediumTextStyle(
                                                fontSize: dimen15,
                                                color: white),
                                          ),
                                          Text(
                                            "${provider.activeconsultationList[index].duration} Min.",
                                            style: mediumTextStyle(
                                                fontSize: dimen15,
                                                color: white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    UiUtils.rejoinAndEndUi(
                                        context,
                                        provider.activeconsultationList[index],
                                        Languages.of(context)!.endConsultation,
                                        Languages.of(context)!.rejoin,
                                        (status_type) {
                                      provider.updateConsultation(
                                          context,
                                          status_type,
                                          provider.activeconsultationList[index]
                                              .conId,
                                          provider.activeconsultationList[index]
                                              .consultationType,
                                          provider.activeconsultationList[index]
                                              .duration!,
                                          provider.activeconsultationList[index]
                                              .chargeAmount!);
                                    }),
                                  ],
                                ),
                              );
                            }),
                        SizedBox(height: 5),
                      ],
                    )
                  : Container(),
              provider.consultationList.length > 0
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: dimen15),
                          child: Text(
                            Languages.of(context)!.consultationRequests,
                            style: semiBoldTextStyle(
                                fontSize: dimen15, color: black),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ListView.builder(
                            itemCount: provider.consultationList.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, int index) {
                              return Container(
                                margin: EdgeInsets.only(left: 15,right: 15,bottom: 15),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.0),
                                    boxShadow: [
                                      BoxShadow(blurRadius: 2, color: lightText)
                                    ]),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 7, horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: blue,
                                          borderRadius: BorderRadius.only(
                                              topRight:
                                                  Radius.circular(dimen12),
                                              topLeft:
                                                  Radius.circular(dimen12))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            Languages.of(context)!
                                                .audioVideoCall,
                                            style: mediumTextStyle(
                                                fontSize: dimen15,
                                                color: white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    UiUtils.callVideoCallUi(
                                        context,
                                        provider.consultationList[index],
                                        Languages.of(context)!.reject,
                                        Languages.of(context)!.accept,
                                        (status_type) {
                                      provider.updateConsultation(
                                          context,
                                          status_type,
                                          provider
                                              .consultationList[index].conId,
                                          provider.consultationList[index]
                                              .consultationType,
                                          "00:00",
                                          0);
                                    }),
                                    provider.consultationList[index]
                                                .partnerName !=
                                            null
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0,
                                              vertical: 15,
                                            ),
                                            child: GlobalButton(
                                                Languages.of(context)!
                                                    .viewPartnerDetails,
                                                white,
                                                yellow, () {
                                              _showPartnerDetails(
                                                  context,
                                                  provider.consultationList[
                                                      index]!);
                                            },
                                                2.0,
                                                0,
                                                mediumTextStyle(
                                                    fontSize: dimen13,
                                                    color: black),
                                                39.0),
                                          )
                                        : Container(),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5.0, left: 15, right: 15),
                                      child: Text(
                                        provider
                                            .consultationList[index].fullName,
                                        style: mediumTextStyle(
                                            fontSize: dimen16, color: black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5.0, left: 15, right: 15),
                                      child: Text(
                                        "${Languages.of(context)!.dob}: ${provider.consultationList[index].dateOfBirth} ${provider.consultationList[index].timeOfBirth}",
                                        style: regularTextStyle(
                                            fontSize: dimen14, color: black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5.0, left: 15, right: 15),
                                      child: Text(
                                        "${provider.consultationList[index].placeOfBirth} - ${provider.consultationList[index].pincode}",
                                        style: mediumTextStyle(
                                            fontSize: dimen14, color: red),
                                      ),
                                    ),
                                    SizedBox(height: 5)
                                  ],
                                ),
                              );
                            }),
                      ],
                    )
                  : Container(),
              SizedBox(height: 50)
            ],
          ),
        ),
      );
    });
  }

  void _showPartnerDetails(BuildContext context, Consultation consultation) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          contentPadding: EdgeInsets.all(16.0),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 5.0, left: 0, right: 5),
                      child: Text(
                        "${Languages.of(context)!.partner_name}: ",
                        style:
                            regularTextStyle(fontSize: dimen16, color: black),
                      ),
                    ),
                    Expanded(
                      // Wraps the Text widget to prevent overflow
                      child: Text(
                        consultation.partnerName!, // Example value
                        style: mediumTextStyle(fontSize: dimen16, color: black),
                        overflow: TextOverflow
                            .ellipsis, // Optional: Truncate if necessary
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      "${Languages.of(context)!.partner_dob}: ",
                      style: regularTextStyle(fontSize: dimen14, color: black),
                    ),
                    Expanded(
                      child: Text(
                        "${consultation.partnerDob!} ${consultation.partnerTob!}", // Example value
                        style: mediumTextStyle(fontSize: dimen16, color: black),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // Aligns multi-line text
                  children: [
                    Text(
                      "${Languages.of(context)!.partner_address}: ",
                      style: regularTextStyle(fontSize: dimen14, color: black),
                    ),
                    Expanded(
                      child: Text(
                        consultation.partnerPob!, // Example value
                        style: mediumTextStyle(fontSize: dimen16, color: black),
                        overflow: TextOverflow.visible, // Multi-line wrapping
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Close",
                style: mediumTextStyle(fontSize: dimen14, color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget image_slider(DashboardProvider provider) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: provider.banner_list.length,
          itemBuilder: (BuildContext context, int index, int realIndex) {
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                // height: 200, // Set height
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://i.pinimg.com/736x/9c/a5/1f/9ca51ff91427f11eefd15e5f2149e800.jpg",
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 180,
            viewportFraction: 0.9,
            // Adjusted to show a portion of the next image
            initialPage: 0,
            onPageChanged: (index, reason) {
              provider.changeBannerIndex(index);
            },
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: provider.banner_list.map((url) {
            int index = provider.banner_list.indexOf(url);
            return Container(
              width: 6.0,
              height: 6.0,
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: provider.currentIndex_banner == index
                    ? secondaryTextColor
                    : inactive_dot_color,
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
