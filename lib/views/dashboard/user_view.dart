import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constance/language/language.dart';
import '../../constance/my_colors.dart';
import '../../constance/textstyle.dart';
import '../../provider/dashboard_provider.dart';
import '../../utils/ui_utils.dart';
class UserView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, provider, child)
    {
      return Scaffold(
        backgroundColor: greyBg,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Card(
                  color: white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey[200], // Optional: to provide a background color
                      child: CachedNetworkImage(
                        imageUrl: provider.profile_image, // Replace with your image URL
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          radius: 24,
                          backgroundImage: imageProvider,
                        ),
                        placeholder: (context, url) => CircularProgressIndicator(), // Placeholder widget
                        errorWidget: (context, url, error) => Icon(Icons.error), // Error widget
                      ),
                    ),

                    title: Text(provider.username,
                        style: mediumTextStyle(
                            fontSize: dimen15, color: colBlack)),
                    subtitle: Text(provider.mobile_no.toString(),
                        style: regularTextStyle(
                            fontSize: dimen14, color: colBlack)),
                  ),
                ),
                const SizedBox(height: 10),

                // Menu Options
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: ListView(
                      children: [
                        UiUtils().menuItem1(provider, context, Languages.of(context)!.personalProfile, Icons.person),
                        UiUtils().menuItem1(provider, context, Languages.of(context)!.bankDetails, Icons.shopping_bag),
                        UiUtils().menuItem1(provider, context, Languages.of(context)!.consultationSchedule, Icons.chat),
                        UiUtils().menuItem1(provider, context, Languages.of(context)!.wallet, Icons.book),
                        UiUtils().menuItem1(provider, context, Languages.of(context)!.consultationHistory, Icons.history),
                        UiUtils().menuItem1(provider, context, Languages.of(context)!.myFollowers, Icons.account_balance_wallet),
                        UiUtils().menuItem1(
                            provider, context, Languages.of(context)!.language, Icons.language,
                            trailing: Text(
                              Languages.of(context)!.english,
                              style: TextStyle(
                                  color: secondaryTextColor, fontSize: dimen16),
                            )),
                        const Divider(height: 40),
                        UiUtils().menuItem1(provider, context, Languages.of(context)!.helpCenter, Icons.help_center),
                        UiUtils().menuItem1(provider, context, Languages.of(context)!.termsAndConditions, Icons.description),
                        UiUtils().menuItem1(provider, context, Languages.of(context)!.privacyPolicies, Icons.privacy_tip),
                        UiUtils().menuItem1(provider, context, Languages.of(context)!.refundPolicies, Icons.money_off),
                        UiUtils().menuItem1(provider, context, Languages.of(context)!.aboutAiAstrology, Icons.info),

                        // Logout Button
                        const SizedBox(height: 20),
                        Center(
                          child: SizedBox(
                            width: double.infinity,
                            // Makes the button occupy full width
                            child: ElevatedButton.icon(
                              onPressed: () {
                                provider.showLogoutDialog(context);
                              },
                              label: Text( Languages.of(context)!.logout,
                                  style: TextStyle(color: secondaryTextColor)),
                              icon: Icon(
                                  Icons.logout, color: secondaryTextColor),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                side: BorderSide(color: secondaryTextColor),
                                padding: EdgeInsets.symmetric(vertical: 8),
                                // Internal padding
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      1), // Corner radius
                                ),
                              ),
                            ),
                          ),

                        ),
                        const SizedBox(height: 20),


                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
