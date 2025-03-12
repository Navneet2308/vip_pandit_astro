import 'package:astrologeradmin/model/Followers.dart';
import 'package:astrologeradmin/provider/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constance/language/language.dart';
import '../../constance/my_colors.dart';
import '../../constance/textstyle.dart';
import '../../provider/dashboard_provider.dart';
import '../../utils/function_utils.dart';

class SupportView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<DashboardProvider>(context, listen: false);
      provider.fetchHelpDeskData();
    });
    return Consumer<DashboardProvider>(builder: (context, provider, child) {
      return Scaffold(
        backgroundColor: bg,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Languages.of(context)!.need_help,
                    style: mediumTextStyle(fontSize: dimen17, color: black),
                  ),
                  SizedBox(height: 3),
                  Text(
                    Languages.of(context)!.connect_with_us_available_options,
                    style:
                        regularTextStyle(fontSize: dimen13, color: lightGrey),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        GestureDetector(
                            onTap: () async {
                              final whatsappUrl = '${provider.helpdesk_data.whatsappChatLink}';
                              await launch(whatsappUrl);
                              if (await canLaunch(whatsappUrl)) {
                              await launch(whatsappUrl);
                              } else {
                              // Handle the error if the email client cannot be opened
                              print('Could not open email client');
                              }
                            },
                            child: Container(

                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 10),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border:
                                      Border.all(color: secondaryTextColor)),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  Languages.of(context)!.start_live_chat,
                                  style: regularTextStyle(
                                      fontSize: 16.0,
                                      color: secondaryTextColor),
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          Languages.of(context)!.connect_through_chat_resolve_issue,
                          style: regularTextStyle(
                              fontSize: dimen12, color: lightText),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final phoneUrl = 'tel:+91${provider.helpdesk_data.supportPhone}';
                            if (await canLaunch(phoneUrl)) {
                              await launch(phoneUrl);
                            } else {
                              // Handle the error if the URL cannot be launched
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 10),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: const BoxDecoration(
                                color: secondaryTextColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "${Languages.of(context)!.call_us} @ +91${provider.helpdesk_data.supportPhone}",
                                style: regularTextStyle(
                                    fontSize: 16.0, color: colWhite),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(Languages.of(context)!.connect_with_one_of_our_support_executives ,
                            style: regularTextStyle(
                                fontSize: dimen12, color: lightText)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final emailUrl = 'mailto:${provider.helpdesk_data.supportEmail}';
                            await launch(emailUrl);
                            if (await canLaunch(emailUrl)) {
                              await launch(emailUrl);
                            } else {
                              // Handle the error if the email client cannot be opened
                              print('Could not open email client');
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 10),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: const BoxDecoration(
                                color: darkYellow,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "${Languages.of(context)!.mail_us} @ ${provider.helpdesk_data.supportEmail}",
                                style: regularTextStyle(
                                    fontSize: dimen16, color: colWhite),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                           Languages.of(context)!.get_call_back_from_executive,
                            style: regularTextStyle(
                                fontSize: dimen12, color: lightText)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
