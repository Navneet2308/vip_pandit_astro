
import 'package:astrologeradmin/provider/dashboard_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constance/language/language.dart';
import '../../constance/my_colors.dart';
import '../../constance/textstyle.dart';


class RechargeWalletBottomSheet extends StatefulWidget {
  final DashboardProvider provider;
  RechargeWalletBottomSheet(this.provider, {Key? key}) : super(key: key);

  @override
  _RechargeWalletBottomSheetState createState() =>
      _RechargeWalletBottomSheetState();
}

class _RechargeWalletBottomSheetState extends State<RechargeWalletBottomSheet> {
  int selectedAmount = 0;
  TextEditingController textEditingController =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Make the bottom sheet scrollable
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              Languages.of(context)!.withdraw_wallet_balance,  // Localized string
              style: mediumTextStyle(
                  fontSize: dimen16, color: colBlackText),
            ),
            SizedBox(height: 8),
            Text(
              Languages.of(context)!.enterAmountTowithdraw,  // Localized string
              style: mediumTextStyle(
                  fontSize: dimen14, color: lightText),
            ),
            SizedBox(height: 16),
            TextField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              controller: textEditingController,
              style: regularTextStyle(
                  fontSize: dimen20, color: colSecondary),
              decoration: InputDecoration(
                hintText: Languages.of(context)!.enterAmount,  // Localized hint text
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(dimen8),
                  borderSide: BorderSide(color:inactive_dot_color),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(dimen8),
                  borderSide: BorderSide(color:inactive_dot_color),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(dimen8),
                  borderSide: BorderSide(color:inactive_dot_color),
                ),
                contentPadding: EdgeInsets.zero, // Remove unnecessary padding
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    selectedAmount = int.tryParse(value) ?? selectedAmount;
                    textEditingController.text = selectedAmount.toString();
                  });
                }
              },
            ),
            SizedBox(height: 16),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (textEditingController.text.isEmpty) {
                  Fluttertoast.showToast(msg: Languages.of(context)!.pleaseEnterAmount);  // Localized message
                  return;
                }
                selectedAmount = int.parse(textEditingController.text);
                if (selectedAmount > 0) {
                  if(selectedAmount>widget.provider.wallet_amount!)
                    {
                      Fluttertoast.showToast(msg: Languages.of(context)!.pleaseEnterValidAmount);  // Localized message
                      return;
                    }
                  Navigator.pop(context);
                  widget.provider.getWithdrwalRequest(context, selectedAmount.toString());
                } else {
                  Fluttertoast.showToast(msg: Languages.of(context)!.pleaseEnterValidAmount);  // Localized message
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colSecondary,
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 12),
              ),
              child: Text(
                Languages.of(context)!.sendRequest,  // Localized string
                style: regularTextStyle(fontSize: dimen16, color: colWhite),
              ),
            ),
          ],
        ),
      )
,
    );
  }
}
