import 'dart:io';

import 'package:astrologeradmin/constance/my_colors.dart';
import 'package:astrologeradmin/model/astro_category_model.dart';
import 'package:astrologeradmin/model/astro_skill_model.dart';
import 'package:astrologeradmin/model/get_languages_model.dart';
import 'package:astrologeradmin/provider/auth_provider.dart';
import 'package:astrologeradmin/views/dashboard/home_view.dart';
import 'package:astrologeradmin/views/pre_register_view.dart';
import 'package:astrologeradmin/views/register_success_screen.dart';
import 'package:astrologeradmin/views/webView/Web_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constance/commonString.dart';
import '../constance/common_Widget.dart';
import '../constance/language/language.dart';
import '../constance/textstyle.dart';
import '../provider/LanguageSelectionProvider.dart';
import '../utils/ui_utils.dart';
import 'package:provider/provider.dart';

import 'dashboard/dashboard_view.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.clearRegisterData(context);
      authProvider.fetchLanguageData();
      authProvider.fetchCategory();
      authProvider.fetchSkills();
    });
    return Scaffold(
      backgroundColor: bg,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Consumer<AuthProvider>(builder: (context, provider, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              UiUtils.topHeaderUi(context),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      Languages.of(context)!.registerAccount,
                      style:
                          mediumTextStyle(fontSize: dimen22, color: colBlack),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      Languages.of(context)!.yourAccountNotRegistered,
                      style:
                          regularTextStyle(fontSize: dimen13, color: colHint),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: textHint, width: 0.5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: ListTile(
                        leading: provider.profileImage.isNotEmpty
                            ? ClipOval(
                                child: Image.file(
                                  File(provider.profileImage),
                                  width: 48, // Diameter of the circle
                                  height: 48,
                                  fit: BoxFit
                                      .cover, // Ensures the image fits within the circle
                                ),
                              )
                            : Container(
                                width: 48, // Diameter of the circle
                                height: 48,
                                child: CircleAvatar(
                                  backgroundImage: const AssetImage(
                                      'assets/images/user_icon.png'),
                                  radius: 24,
                                ),
                              ),
                        title: Text(
                          Languages.of(context)!.aiAstrologyS,
                          style: mediumTextStyle(
                              fontSize: dimen15, color: colBlack),
                        ),
                        subtitle: Text(
                          provider.mobile_no!,
                          style: regularTextStyle(
                              fontSize: dimen14, color: colBlack),
                        ),
                        trailing: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            // Light grey background color
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(Icons.camera_alt_outlined,
                                  color: colSecondary),
                            ), // Camera icon
                            onPressed: () {
                              provider.pickImage();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Use Consumer to listen to changes in RegisterScreenProvider
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      buildTextField(
                        context,
                        Languages.of(context)!.fullName,
                        Languages.of(context)!.enterFullName,
                        provider.updateName,
                        provider.name,
                      ),
                      const SizedBox(height: 10),
                      buildTextField(
                        context,
                        Languages.of(context)!.emailAddress,
                        Languages.of(context)!.enterEmailAddress,
                        provider.updateEmail,
                        provider.email,
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: buildDatePickerField(
                          context,
                          Languages.of(context)!.dateOfBirth,
                          "YYYY-MM-DD",
                          provider.updateDob,
                          // Callback to update the selected date
                          provider.dob, // Current selected date value
                        ),
                      ),
                      const SizedBox(height: 10),
                      buildTextField(
                        context,
                        Languages.of(context)!.currentCity,
                        Languages.of(context)!.enterCurrentCity,
                        provider.updateCity,
                        provider.city,
                      ),
                      const SizedBox(height: 10),
                      buildTextField(
                        context,
                        Languages.of(context)!.currentFullAddress,
                        Languages.of(context)!.enterFullAddress,
                        provider.updateAddress,
                        provider.address,
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildHalfWidthTextField(
                              context,
                              Languages.of(context)!.pincode,
                              Languages.of(context)!.enterPincode,
                              provider.updatePincode,
                              provider.pincode,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            _buildHalfWidthDropdownField(
                              context,
                              Languages.of(context)!.gender,
                              Languages.of(context)!.selectGender,
                              provider.updateGender,
                              // Callback to update the selected gender
                              provider.gender,
                              // Current selected gender value
                              [
                                "Male",
                                "Female",
                                "Other"
                              ], // List of gender options
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),

                      // buildLanguageHalfWidthDropdownField(context,
                      //     "Language Known", "e.g., Hindi, English",
                      //         (List<LanguagesModel> selected) {
                      //       provider.selected_langauge = selected;
                      //     }, provider.selected_langauge,
                      //     provider.languageList, provider),

                      provider.buildCategoryHalfWidthDropdownField(
                          context,
                          Languages.of(context)!.astro_Exper_cat,
                          "e.g., Love & Relationship",
                          (List<AstrologyCategoryModel> selected) {
                            provider.selected_catModel = selected;
                           },
                          provider.selected_catModel, provider.categoryList,
                          provider),
                      const SizedBox(height: 10),
                      provider.buildSkillHalfWidthDropdownField(
                          context,
                          Languages.of(context)!.astro_skills,
                          Languages.of(context)!.type_skill_name,
                          (List<AstrologySkillModel> selected) {
                        provider.selected_Skill = selected;
                      }, provider.selected_Skill, provider.skillList, provider),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: provider
                                  .buildLanguageHalfWidthDropdownField(
                                      context,
                                      Languages.of(context)!.language_know,
                                      "e.g., Hindi, English",
                                      (List<LanguagesModel> selected) {
                                provider.selected_langauge = selected;
                              }, provider.selected_langauge,
                                      provider.languageList, provider),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            buildHalfWidthTextField(
                              context,
                              Languages.of(context)!.exp_in_year,
                              Languages.of(context)!.enter_exp,
                              provider.updateExperience,
                              provider.experience,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildHalfWidthTextField(
                              context,
                              Languages.of(context)!.chatChargePerMin,
                              Languages.of(context)!.enter_charge,
                              provider.updateChatCharge,
                              provider.chatCharge,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            buildHalfWidthTextField(
                              context,
                              Languages.of(context)!.callChargePerMin,
                              Languages.of(context)!.enter_charge,
                              provider.updateCallCharge,
                              provider.callCharge,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      buildTextFieldProfileBio(
                        context,
                        Languages.of(context)!.astor_profile_bio,
                        Languages.of(context)!.astor_profile_bio_detail,
                        provider.updateProfileBio,
                        provider.profileBio,
                      ),
                      const SizedBox(height: 10),
                      buildTextField(
                        context,
                        Languages.of(context)!.adhar_card_number,
                        Languages.of(context)!.enter_adhar_card_number,
                        provider.updateAadharNumber,
                        provider.aadharNumber,
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _builbfUploadButton(
                              provider,
                              Languages.of(context)!.adhar_front_photo,
                              provider.uploadAadharFrontPhoto,
                              provider.aadharFrontPhoto,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            _buildbUploadButton(
                              provider,
                              Languages.of(context)!.adhar_back_photo,
                              provider.uploadAadharBackPhoto,
                              provider.aadharBackPhoto,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardView(),));
                      provider.register(context);
                    },
                    child: Container(
                      // height: 48,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: const BoxDecoration(
                          color: secondaryTextColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          Languages.of(context)!.registerAccount,
                          style: semiBoldTextStyle(
                              fontSize: 16.0, color: colWhite),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: regularTextStyle(fontSize: 13.0, color: lightText),
                    children: [
                      TextSpan(
                          text: Languages.of(context)!.bySigningUpYouAgree),
                      TextSpan(
                        text: " "+Languages.of(context)!.termsAndConditions,
                        style: regularTextStyle(
                            fontSize: 13.0, color: secondaryTextColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => WebView(heading: Languages.of(context)!.termsAndConditions,url: termsConditions)),
                            );
                          },
                      ),
                      TextSpan(
                          text: Languages.of(context)!.and,
                          style: regularTextStyle(
                              fontSize: 13.0, color: lightText)),
                      TextSpan(
                        text: Languages.of(context)!.privacyPolicy,
                        style: regularTextStyle(
                            fontSize: 13.0, color: secondaryTextColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => WebView(heading: Languages.of(context)!.privacyPolicy,url: privacyPolicy)),
                            );
                          },
                      ),
                    ],
                  ),
                ),
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

  Widget _buildHalfWidthDropdownField(
    BuildContext context,
    String label,
    String hintText,
    Function(String) onChanged,
    String selectedValue,
    List<String> items,
  ) {
    print("selectedValue"+selectedValue);
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: regularTextStyle(fontSize: dimen15, color: colBlack),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              height: 50,
              child: DropdownButtonFormField<String>(
                value: selectedValue.isEmpty ? null : selectedValue,
                decoration: InputDecoration(
                  // labelText: label,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: items
                    .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        ))
                    .toList(),
                onChanged: (value) {
                  onChanged(value!);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _builbfUploadButton(AuthProvider provider, String label,
      void Function(String) onPressed, String? fileName) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: regularTextStyle(fontSize: dimen15, color: colBlack),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: InkWell(
              onTap: () {
                provider.pickAdharFrontImage();
              },
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  border: Border.all(color: textHint, width: 0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: provider.aadharFrontPhoto!.isEmpty
                      ? Icon(
                    Icons.camera_alt_outlined,
                    color: secondaryTextColor,
                  )
                      : ClipOval(
                    child: Image.file(
                      File(provider.aadharFrontPhoto!),
                      width: 45, // Diameter of the circle
                      height: 45,
                      fit: BoxFit
                          .cover, // Ensures the image fits within the circle
                    ),

                  )

                  //         ClipOval(
                  //     child: Image.file(
                  //     File(provider.profileImage),
                  //     width: 48, // Diameter of the circle
                  //     height: 48,
                  //     fit: BoxFit
                  //         .cover, // Ensures the image fits within the circle
                  //   ),
                  // )

                  ,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildbUploadButton(AuthProvider provider, String label,
      void Function(String) onPressed, String? fileName) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: regularTextStyle(fontSize: dimen15, color: colBlack),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: InkWell(
              onTap: () {
                provider.pickAdharBackImage();
              },
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  border: Border.all(color: textHint, width: 0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: provider.aadharBackPhoto!.isEmpty
                          ? Icon(
                              Icons.camera_alt_outlined,
                              color: secondaryTextColor,
                            )
                          : ClipOval(
                              child: Image.file(
                                File(provider.aadharBackPhoto!),
                                width: 45, // Diameter of the circle
                                height: 45,
                                fit: BoxFit
                                    .cover, // Ensures the image fits within the circle
                              ),
                            )

                  //         ClipOval(
                  //     child: Image.file(
                  //     File(provider.profileImage),
                  //     width: 48, // Diameter of the circle
                  //     height: 48,
                  //     fit: BoxFit
                  //         .cover, // Ensures the image fits within the circle
                  //   ),
                  // )

                  ,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
