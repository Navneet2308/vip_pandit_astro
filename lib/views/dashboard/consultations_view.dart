import 'package:astrologeradmin/provider/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constance/language/language.dart';
import '../../constance/my_colors.dart';
import '../../constance/textstyle.dart';
import '../../provider/dashboard_provider.dart';
import '../../utils/function_utils.dart';
import '../../utils/ui_utils.dart';

class ConsultantionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<DashboardProvider>(context, listen: false);
      provider.getClosedConsultation(context);
    });
    return Consumer<DashboardProvider>(
      builder: (context, provider, child) {
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
                      Languages.of(context)!.consultation_history,
                      style: mediumTextStyle(fontSize: dimen17, color: black),
                    ),
                    SizedBox(height: 3),
                    Text(
                      Languages.of(context)!.detail_consultation_transaction,
                      style:
                          regularTextStyle(fontSize: dimen13, color: lightGrey),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                provider.closedconsultationList.isNotEmpty
                    ? Expanded(
                        // Added Expanded here
                        child: ListView.builder(
                          itemCount: provider.closedconsultationList.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, int index) {
                            return ConsultationCard(
                              context,
                              provider.closedconsultationList[index].conId
                                  .toString(),
                              provider.closedconsultationList[index].fullName,
                              convertDateTime(provider
                                  .closedconsultationList[index].createdAt),
                              "₹ ${provider.closedconsultationList[index].chargeAmount}",
                              "${convertTimeFormat(provider.closedconsultationList[index].duration.toString())} - 5/Min",
                              provider.closedconsultationList[index]
                                          .consultationType ==
                                      2
                                  ? "Video"
                                  : "Chat",
                              provider.closedconsultationList[index].rating !=
                                      null
                                  ? provider
                                      .closedconsultationList[index].rating!
                                      .toInt()
                                  : 0,
                              provider.closedconsultationList[index].review !=
                                      null
                                  ? provider
                                      .closedconsultationList[index].review
                                  : "",
                              provider.closedconsultationList[index]
                                          .consultationType ==
                                      2
                                  ? Colors.blueAccent
                                  : Colors.green,
                            );
                          },
                        ),
                      )
                    : Expanded(child: UiUtils.noDataAvailableWidget()),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget ConsultationCard(
    BuildContext context,
    String order_id,
    String name,
    String dateTime,
    String price,
    String duration,
    String interactionType,
    int? rating,
    String? review,
    Color buttonColor) {
  return Card(
    color: Colors.white,
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "#" + order_id,
            style:
                mediumTextStyle(fontSize: dimen14, color: secondaryTextColor),
          ),
          SizedBox(
            height: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: semiBoldTextStyle(fontSize: dimen17, color: colBlack),
              ),
              Text(
                price,
                style:
                    boldTextStyle(fontSize: dimen19, color: secondaryTextColor),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "${Languages.of(context)!.date_time}: $dateTime",
            style: mediumTextStyle(fontSize: dimen13, color: lightGrey),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                duration,
                style: mediumTextStyle(fontSize: dimen13, color: lightGrey),
              ),
              Container(
                decoration: BoxDecoration(
                  color: interactionType == "Chat" ? colGreen : blue,
                  // Background color
                  borderRadius: BorderRadius.circular(2), // Rounded corners
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                // Padding for the text
                child: Text(
                  interactionType,
                  style: TextStyle(
                    color: Colors.white, // Text color
                    fontSize: dimen10, // Text size
                  ),
                ),
              ),
            ],
          ),
          if (rating != null && review != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Divider(
                thickness: 0.3,
              ),
            ),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  color: Colors.yellow,
                );
              }),
            ),
            const SizedBox(height: 4),
            Text(review!,
                style: mediumTextStyle(fontSize: dimen12, color: colBlack)),
          ],
        ],
      ),
    ),
  );
}
