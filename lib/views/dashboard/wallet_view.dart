import 'package:astrologeradmin/constance/assets_path.dart';
import 'package:astrologeradmin/model/withDrwalHistory.dart';
import 'package:astrologeradmin/utils/function_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constance/language/language.dart';
import '../../constance/my_colors.dart';
import '../../constance/textstyle.dart';
import '../../model/AstroEarning.dart';
import '../../provider/dashboard_provider.dart';
import '../../utils/ui_utils.dart';
import '../bottomsheet/RechargeWalletBottomSheet.dart';

class WalletView extends StatelessWidget {
  void _showRechargeBottomSheet(
      BuildContext context, DashboardProvider provider) async {
    final result = await showModalBottomSheet<int>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return RechargeWalletBottomSheet(provider); // BottomSheet widget
      },
    );
    if (result != null) {
      // selectedRechargeAmount = result.toString();
      // controller.updateWallet(context, selectedRechargeAmount);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.changeWallettab(0, context);
      // provider.getWithdrwalRequest(context,"5");
    });
    return Consumer<DashboardProvider>(builder: (context, chatProvider, child) {
      return Scaffold(
        backgroundColor: bg,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Languages.of(context)!.myWalletBalance,
                style: mediumTextStyle(fontSize: dimen14, color: black),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        AssetsPath.wallet_icon_small,
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(width: 8),
                      Text(
                        '₹ ${provider.wallet_amount.toString()}',
                        style:
                            boldTextStyle(fontSize: dimen20, color: colBlack),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      _showRechargeBottomSheet(context, provider);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: secondaryTextColor, // Background color
                        borderRadius:
                            BorderRadius.circular(4), // Rounded corners
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      // Padding for the text
                      child: Text(
                        Languages.of(context)!.withdrawBalance,
                        style:
                            semiBoldTextStyle(fontSize: dimen13, color: white),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 25),
              // Wallet History Section
              Text(
                Languages.of(context)!.walletHistory,
                style: semiBoldTextStyle(fontSize: dimen16, color: colBlack),
              ),
              Text(
                Languages.of(context)!.walletTransactionsData,
                style: regularTextStyle(fontSize: dimen13, color: Colors.grey),
              ),
              SizedBox(height: 30),
              // Earnings/Withdrawals Tab
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        provider.changeWallettab(0, context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: provider.wallet_tab_index == 0
                              ? Colors.yellow
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          Languages.of(context)!.earnings,
                          style: mediumTextStyle(
                              fontSize: dimen14, color: colBlack),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        provider.changeWallettab(1, context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: provider.wallet_tab_index == 1
                              ? Colors.yellow
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          Languages.of(context)!.withdrawals,
                          style: mediumTextStyle(
                              fontSize: dimen14, color: colBlack),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              provider.wallet_tab_index == 0
                  ? (provider.earningList.length > 0
                      ? Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, bottom: 0),
                            child: ListView.builder(
                              itemCount: provider.earningList.length,
                              itemBuilder: (context, index) {
                                return EarningCard(
                                  context,
                                  provider.earningList[index],
                                );
                              },
                            ),
                          ),
                        )
                      : Expanded(child: UiUtils.noDataAvailableWidget()))
                  : (provider.withdrawalList.length > 0
                      ? Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, bottom: 0),
                            child: ListView.builder(
                              itemCount: provider.withdrawalList.length,
                              itemBuilder: (context, index) {
                                return WithdrawlCard(
                                  context,
                                  provider.withdrawalList[index],
                                );
                              },
                            ),
                          ),
                        )
                      : Expanded(child: UiUtils.noDataAvailableWidget()))
            ],
          ),
        ),
      );
    });
  }

  Widget WithdrawlCard(BuildContext context, WithdrawlData earning_data) {
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
              "#" + earning_data.wrId.toString(),
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
                  "Balance Withdrawal",
                  style: semiBoldTextStyle(fontSize: dimen17, color: colBlack),
                ),
                Column(
                  children: [
                    Text(
                      earning_data.requestAmount.toString(),
                      style: boldTextStyle(fontSize: dimen20, color: yellow),
                    ),
                    Text("Pending",
                        style:
                            regularTextStyle(fontSize: dimen12, color: yellow)),
                  ],
                ),
              ],
            ),
            Text(
              "${Languages.of(context)!.date_time}: ${convertDateTime(earning_data.createdAt.toString())}",
              style: mediumTextStyle(fontSize: dimen13, color: lightGrey),
            ),
          ],
        ),
      ),
    );
  }

  Widget EarningCard(BuildContext context, EarningData earning_data) {
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
              "#" + earning_data.conId.toString(),
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
                  earning_data.customerName,
                  style: semiBoldTextStyle(fontSize: dimen17, color: colBlack),
                ),
                Text(
                  earning_data.totalAmount.toString(),
                  style: boldTextStyle(
                      fontSize: dimen20, color: secondaryTextColor),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "${Languages.of(context)!.date_time}: ${convertDateTime(earning_data.consultationDetails.createdAt.toString())}",
              style: mediumTextStyle(fontSize: dimen13, color: lightGrey),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${convertTimeFormat(earning_data.duration.toString())} - ${earning_data.costPerMin}/Min",
                  style: mediumTextStyle(fontSize: dimen13, color: lightGrey),
                ),
                earning_data.consultation_type == 1
                    ? Container(
                        decoration: BoxDecoration(
                          color: blue,
                          // Background color
                          borderRadius:
                              BorderRadius.circular(2), // Rounded corners
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                        // Padding for the text
                        child: Text(
                          Languages.of(context)!.chat,
                          style: TextStyle(
                            color: Colors.white, // Text color
                            fontSize: dimen10, // Text size
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: colGreen,
                          // Background color
                          borderRadius:
                              BorderRadius.circular(2), // Rounded corners
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                        // Padding for the text
                        child: Text(
                          Languages.of(context)!.audioVideoCall,
                          style: TextStyle(
                            color: Colors.white, // Text color
                            fontSize: dimen10, // Text size
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
