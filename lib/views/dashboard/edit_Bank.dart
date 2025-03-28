import 'dart:io';
import 'package:astrologeradmin/constance/my_colors.dart';
import 'package:astrologeradmin/model/astro_category_model.dart';
import 'package:astrologeradmin/model/astro_skill_model.dart';
import 'package:astrologeradmin/model/get_languages_model.dart';
import 'package:astrologeradmin/provider/auth_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../constance/common_Widget.dart';
import '../../constance/language/language.dart';
import '../../constance/textstyle.dart';
import '../../provider/dashboard_provider.dart';
import '../../utils/ui_utils.dart';

class EditBank extends StatelessWidget {
  const EditBank({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<DashboardProvider>(context, listen: false);
      provider.getBankDetails();
      provider.getBankAccountAPI(context);
    });
    return Scaffold(
      backgroundColor: bg,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(child:
            Consumer<DashboardProvider>(builder: (context, provider, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              // Inside the Column with TextFields
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  bankStatusWidget(context, provider),
                  const SizedBox(height: 10),
                  buildTextBankField(
                    context,
                    Languages.of(context)!.bank_name,
                    Languages.of(context)!.enter_bank_name,
                    provider.updateBankName,
                    provider.bank_name,
                    isEditable: provider.bank_Ac_approved == 0 ||
                        provider.bank_Ac_approved == 3,
                  ),
                  const SizedBox(height: 10),
                  buildTextBankField(
                    context,
                    Languages.of(context)!.bank_ifsc_code,
                    Languages.of(context)!.enter_bank_ifsc_code,
                    provider.updateBankIfsc,
                    provider.bank_ifsc,
                    isEditable: provider.bank_Ac_approved == 0 ||
                        provider.bank_Ac_approved == 3,
                  ),
                  const SizedBox(height: 10),
                  buildTextBankField(
                    context,
                    Languages.of(context)!.account_number,
                    Languages.of(context)!.enter_account_number,
                    provider.updateBankAccount,
                    provider.bank_accountno,
                    isEditable: provider.bank_Ac_approved == 0 ||
                        provider.bank_Ac_approved == 3,
                  ),
                  const SizedBox(height: 10),
                  buildTextBankField(
                    context,
                    Languages.of(context)!.account_holder_name,
                    Languages.of(context)!.bank_account_holder_name,
                    provider.updateBankHolder,
                    provider.bank_holdername,
                    isEditable: provider.bank_Ac_approved == 0 ||
                        provider.bank_Ac_approved == 3,
                  ),
                  const SizedBox(height: 25),
                  GestureDetector(
                    onTap: () {
                      provider.UpdateBankDetails(context);
                    },
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: provider.bank_Ac_approved == 0 ||
                                  provider.bank_Ac_approved == 3
                              ? secondaryTextColor
                              : lightGrey,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          Languages.of(context)!.update_bank_details,
                          style: semiBoldTextStyle(
                              fontSize: 16.0, color: colWhite),
                        ),
                      ),
                    ),
                  )
                ],
              ),

              const SizedBox(
                height: 30,
              )
            ],
          );
        })),
      ),
    );
  }

  Widget bankStatusWidget(BuildContext context, provider) {
    Color backgroundColor;
    String statusText;

    switch (provider.bank_Ac_approved) {
      case 0:
        backgroundColor = lightGrey;
        statusText = Languages.of(context)!.not_applied;
        break;
      case 1:
        backgroundColor = Colors.green;
        statusText = Languages.of(context)!.kyc_approved;
        break;
      case 2: // Approved
        backgroundColor = Colors.yellow;
        statusText = Languages.of(context)!.kyc_pending;
        break;
      case 3: // Rejected
        backgroundColor = rejected_btn_color;
        statusText = Languages.of(context)!.kyc_rejected;
        break;
      default:
        return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 33.0,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.symmetric(vertical: 0),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(2)),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              statusText,
              style: mediumTextStyle(fontSize: dimen14, color: colWhite),
            ),
          ),
        ),
        if (provider.bank_Ac_approved == 3) // Show reason only when rejected
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              provider.bank_Ac_rejected_reason,
              textAlign: TextAlign.start,
              style:
                  regularTextStyle(fontSize: dimen14, color: warning_txt_color),
            ),
          ),
      ],
    );
  }
}
