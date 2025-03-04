import 'package:astrologeradmin/model/Followers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constance/language/language.dart';
import '../../constance/my_colors.dart';
import '../../constance/textstyle.dart';
import '../../provider/dashboard_provider.dart';
import '../../utils/function_utils.dart';

class FollowersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<DashboardProvider>(context, listen: false);
      provider.getFollowers(context);
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
                    Languages.of(context)!.my_followers,
                    style: mediumTextStyle(fontSize: dimen17, color: black),
                  ),
                  SizedBox(height: 3),
                  Text(
                    Languages.of(context)!.list_of_customer_following_you,
                    style:
                        regularTextStyle(fontSize: dimen13, color: lightGrey),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: provider.followersList.length,
                    itemBuilder: (context, index) {
                      final follower = provider.followersList[index];
                      return followerCard(context,follower);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget followerCard(BuildContext context,Followers follower) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Card(
          color: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                    follower.cusProfilePhoto!, // Replace with actual image URL
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      follower.customerName!,
                      style: semiBoldTextStyle(fontSize: dimen15, color: colBlack),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "${Languages.of(context)!.following_from}: ${convertDate(follower.createdAt!)}",
                      style: regularTextStyle(fontSize: dimen14, color: black),

                    ),
                  ],
                ),
              ],
            ),
          )),
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
                    boldTextStyle(fontSize: dimen20, color: secondaryTextColor),
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
