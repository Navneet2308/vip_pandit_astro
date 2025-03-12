import 'dart:async';
import 'dart:io';

import 'package:astrologeradmin/constance/ProgressDialog.dart';
import 'package:astrologeradmin/model/AstrologerRegisterModel.dart';
import 'package:astrologeradmin/model/astro_category_model.dart';
import 'package:astrologeradmin/model/common_response.dart';
import 'package:astrologeradmin/model/get_languages_model.dart';
import 'package:astrologeradmin/services/api_path.dart';
import 'package:astrologeradmin/services/user_prefences.dart';
import 'package:astrologeradmin/services/web_services.dart';
import 'package:astrologeradmin/views/dashboard/dashboard_view.dart';
import 'package:astrologeradmin/views/pre_register_view.dart';
import 'package:astrologeradmin/views/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../constance/my_colors.dart';
import '../constance/textstyle.dart';
import '../model/Astrologer.dart';
import '../model/astro_skill_model.dart';
import '../model/quiz_response.dart';
import '../services/ApiService.dart';
import '../utils/function_utils.dart';
import '../views/register_success_screen.dart';
import '../widget/navigators.dart';
import 'LanguageSelectionProvider.dart';

class AuthProvider extends ChangeNotifier {
  List<LanguagesModel> _languageList = [];

  List<LanguagesModel> get languageList => _languageList;

  List<AstrologyCategoryModel> _categoryList = [];

  var resendTime = 60;
  late Timer timer;

  List<AstrologyCategoryModel> get categoryList => _categoryList;

  List<AstrologySkillModel> _skillList = [];

  List<AstrologySkillModel> get skillList => _skillList;

  List<AstrologyQuiz> _quizList = [];

  List<AstrologyQuiz> get quizList => _quizList;

  // Getters
  List<LanguagesModel> selected_langauge = [];
  List<AstrologyCategoryModel> selected_catModel = [];
  List<AstrologySkillModel> selected_Skill = [];

  int astro_id = 0;

  String name = '';
  String email = '';
  String dob = '';
  String doi = '';

  String city = '';
  String address = '';
  String pincode = '';
  String gender = 'Male';
  String experience = '';
  String chatCharge = '';
  String callCharge = '';
  String profileBio = '';
  String profileImage = '';
  String aadharNumber = '';
  String? aadharFrontPhoto = '';
  String? aadharBackPhoto = '';
  String? mobile_no = '';
  String? _responseMessage;

  String? _otp;

  String? get otp => _otp;

  bool isLoading = false;

  final ApiService apiService = ApiService();

  // Method to send OTP
  Future<void> sendOtp(BuildContext context) async {
    await _makeRequest(context, ApiPath.send_otp, {'mobile_no': mobile_no});
  }

  Future<void> resendsendOtp(BuildContext context) async {
    await _makeRequest(context, ApiPath.send_otp, {'mobile_no': mobile_no});
  }

  void updateAnswer(int questionIndex, String answer) {
    quizList[questionIndex].answer = answer;
    notifyListeners();
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImage = image!.path.toString();
      notifyListeners();
    }
  }

  Future<void> pickAdharFrontImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      aadharFrontPhoto = image!.path.toString();
      notifyListeners();
    }
  }

  void cancelTimer() {
    // if (timer.isActive) {
    //   timer.cancel();
    //   print("Timer canceled successfully");
    // } else {
    //   print("Timer already inactive");
    // }
  }
  void startTimer() {
    resendTime = 60;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTime > 0) {
        resendTime--;
      } else {
        timer.cancel();
      }
      notifyListeners();
    });
  }

  String getFormattedTime() {
    int minutes = (resendTime ~/ 60);
    int seconds = (resendTime % 60);
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  void _showSkillSelectionBottomSheet(
    BuildContext context,
    List<AstrologySkillModel> items,
  ) {
    final provider =
        Provider.of<BottomSheetSelectionProvider>(context, listen: false);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Select Category",
                  style: semiBoldTextStyle(fontSize: dimen16, color: colBlack),
                ),
              ),
              Expanded(
                child: Consumer<BottomSheetSelectionProvider>(
                  builder: (context, provider, child) {
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final skill = items[index];
                        final isSelected =
                            provider.selectedastoSkill.contains(skill);
                        return InkWell(
                          onTap: () {
                            provider.toggleSkill(skill);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: isSelected,
                                  onChanged: (bool? value) {
                                    provider.toggleSkill(skill);
                                  },
                                ),
                                Text(
                                  skill.skill_name ?? "",
                                  style: mediumTextStyle(
                                      fontSize: dimen14, color: colBlack),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    backgroundColor: secondaryTextColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  onPressed: () {
                    selected_Skill.clear();
                    selected_Skill.addAll(provider.selectedastoSkill);
                    notifyListeners();
                    Navigator.pop(context);
                  },
                  child: Center(
                      child: Text(
                    "Done",
                    style: mediumTextStyle(fontSize: dimen16, color: white),
                  )),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCategorySelectionBottomSheet(
    BuildContext context,
    List<AstrologyCategoryModel> items,
  ) {
    final provider =
        Provider.of<BottomSheetSelectionProvider>(context, listen: false);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Select Category",
                  style: semiBoldTextStyle(fontSize: dimen16, color: colBlack),
                ),
              ),
              Expanded(
                child: Consumer<BottomSheetSelectionProvider>(
                  builder: (context, provider, child) {
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final category = items[index];
                        final isSelected =
                            provider.selectedastoCat.contains(category);
                        return InkWell(
                          onTap: () {
                            provider.toggleCategory(category);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: isSelected,
                                  onChanged: (bool? value) {
                                    provider.toggleCategory(category);
                                  },
                                ),
                                Text(
                                  category.categoryName ?? "",
                                  style: mediumTextStyle(
                                      fontSize: dimen14, color: colBlack),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    backgroundColor: secondaryTextColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  onPressed: () {
                    selected_catModel.clear();
                    selected_catModel.addAll(provider.selectedastoCat);
                    notifyListeners();
                    Navigator.pop(context);
                  },
                  child: Center(
                      child: Text(
                    "Done",
                    style: mediumTextStyle(fontSize: dimen16, color: white),
                  )),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> saveQuiz(BuildContext context) async {
    ProgressDialog.show(context);
    String validation = validatequiz()!;
    if (validation.isEmpty) {
      List<Map<String, dynamic>> quizListJson =
          quizList.map((quiz) => quiz.toJson()).toList() ?? [];
      Map<String, dynamic> body = {
        "astro_id": astro_id,
        "quiz_result": quizListJson.toString(),
        "reject_reason": "",
        "interview_time": doi
      };
      notifyListeners();
      try {
        final response = await apiService.post(ApiPath.saveQuiz, body);
        final commnon_reponse = CommonResponse.fromJson(response);
        _responseMessage =
            commnon_reponse.message ?? 'Unknown response message';
        if (commnon_reponse != null) {
          if (commnon_reponse.error!.isNotEmpty) {
            showErrorSnackBar(context, commnon_reponse.error!);
          } else {
            showSuccessSnackBar(context, _responseMessage!!);
            CustomNavigators.pushReplacementNavigate(
                RegisterSuccessScreen(), context);
          }
        }
        ProgressDialog.hide(context);
      } catch (error) {
        ProgressDialog.hide(context);
        showErrorSnackBar(context, error.toString());
      } finally {
        ProgressDialog.hide(context);
        notifyListeners();
      }
      // CustomNavigators.pushNavigate(RegisterSuccessScreen(), context);
    } else {
      showErrorSnackBar(context, validation);
    }
    //
  }

  void _showLanguageSelectionBottomSheet(
    BuildContext context,
    List<LanguagesModel> items,
  ) {
    final provider =
        Provider.of<BottomSheetSelectionProvider>(context, listen: false);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Select Languages",
                  style: semiBoldTextStyle(fontSize: dimen16, color: colBlack),
                ),
              ),
              Expanded(
                child: Consumer<BottomSheetSelectionProvider>(
                  builder: (context, languageProvider, child) {
                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final language = items[index];
                        final isSelected = languageProvider.selectedLanguages
                            .contains(language);
                        return InkWell(
                          onTap: () {
                            languageProvider.toggleLanguage(language);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: isSelected,
                                  onChanged: (bool? value) {
                                    languageProvider.toggleLanguage(language);
                                  },
                                ),
                                Text(
                                  language.languageName ?? "",
                                  style: mediumTextStyle(
                                      fontSize: dimen14, color: colBlack),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    backgroundColor: secondaryTextColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  onPressed: () {
                    selected_langauge.clear();
                    selected_langauge.addAll(provider.selectedLanguages);
                    notifyListeners();
                    Navigator.pop(context);
                  },
                  child: Center(
                      child: Text(
                    "Done",
                    style: mediumTextStyle(fontSize: dimen16, color: white),
                  )),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildSkillHalfWidthDropdownField(
    BuildContext context,
    String label,
    String hintText,
    Function(List<AstrologySkillModel>) onChanged,
    List<AstrologySkillModel> selectedValues,
    List<AstrologySkillModel> items,
    AuthProvider provider,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                _showSkillSelectionBottomSheet(context, items);
              },
              child: Container(
                alignment: Alignment.centerLeft,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: lightGrey, width: 0.6),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
                child: Text(
                  selectedValues.isNotEmpty
                      ? selectedValues.map((e) => e.skill_name).join(', ')
                      : hintText,
                  style: selectedValues.isNotEmpty
                      ? mediumTextStyle(fontSize: dimen14, color: colBlack)
                      : regularTextStyle(
                          fontSize: dimen13,
                          color: black.withOpacity(0.70),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryHalfWidthDropdownField(
    BuildContext context,
    String label,
    String hintText,
    Function(List<AstrologyCategoryModel>) onChanged,
    List<AstrologyCategoryModel> selectedValues,
    List<AstrologyCategoryModel> items,
    AuthProvider provider,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                _showCategorySelectionBottomSheet(context, items);
              },
              child: Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: lightGrey, width: 0.6),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
                child: Text(
                  selectedValues.isNotEmpty
                      ? selectedValues.map((e) => e.categoryName).join(', ')
                      : hintText,
                  style: selectedValues.isNotEmpty
                      ? mediumTextStyle(fontSize: dimen14, color: colBlack)
                      : regularTextStyle(
                          fontSize: dimen13,
                          color: black.withOpacity(0.70),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLanguageHalfWidthDropdownField(
    BuildContext context,
    String label,
    String hintText,
    Function(List<LanguagesModel>) onChanged,
    List<LanguagesModel> selectedValues,
    List<LanguagesModel> items,
    AuthProvider provider,
  ) {
    return Column(
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
              _showLanguageSelectionBottomSheet(context, items);
            },
            child: Container(
              alignment: Alignment.centerLeft,

              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: lightGrey, width: 0.6),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),

              child: Text(
                selectedValues.isNotEmpty
                    ? selectedValues.map((e) => e.languageName).join(', ')
                    : hintText,
                style: selectedValues.isNotEmpty
                    ? mediumTextStyle(fontSize: dimen14, color: colBlack)
                    : regularTextStyle(
                        fontSize: dimen13,
                        color: black.withOpacity(0.70),
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> pickAdharBackImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      aadharBackPhoto = image!.path.toString();
      notifyListeners();
    }
  }

  Future<void> callRegisterApi(BuildContext context) async {
    List<int> astro_cat = [];
    List<int> astro_lang = [];
    List<int> astro_skill = [];
    astro_cat
        .addAll(selected_catModel.map((cat) => cat.acatId).whereType<int>());
    astro_lang
        .addAll(selected_langauge.map((lng) => lng.langId).whereType<int>());
    astro_skill
        .addAll(selected_Skill.map((lng) => lng.skill_id).whereType<int>());

    Map<String, dynamic> body = {
      "full_name": name,
      "mobile_no": mobile_no,
      "email_id": email,
      "date_of_birth": dob,
      "astro_living_city": city,
      "full_address": address,
      "pincode": pincode,
      "gender": gender,
      "acat_id": astro_cat,
      "astro_skills": astro_skill,
      "astro_language": astro_lang,
      "astro_experience": experience,
      "astro_chat_charge": chatCharge,
      "astro_minute_charge": callCharge,
      "astro_profile_bio": profileBio,
      "adhar_card": aadharNumber,
    };
    ProgressDialog.show(context);
    try {
      final response = await apiService.register_post(
          ApiPath.register,
          body,
          File(profileImage),
          File(aadharFrontPhoto ?? ''),
          File(aadharBackPhoto ?? ''));
      final signupResponse = AstrologerRegisterModel.fromJson(response);

      if (signupResponse.message != null) {
        _responseMessage = signupResponse.message ?? 'Unknown response message';
      } else {
        _responseMessage = "Unknown response message";
      }
      if (signupResponse != null) {
        if (signupResponse.error != null && signupResponse.error!.isNotEmpty) {
          showErrorSnackBar(context, signupResponse.error!);
        } else {
          astro_id = signupResponse.data!.astroId!;
          showSuccessSnackBar(context, _responseMessage!!);
          CustomNavigators.pushReplacementNavigate(PreRegisterView(), context);
        }
      }
      ProgressDialog.hide(context);
    } catch (error) {
      ProgressDialog.hide(context);
      showErrorSnackBar(context, error.toString());
    } finally {
      ProgressDialog.hide(context);
      notifyListeners();
    }
  }

  Future<void> login(String phoneNumber, BuildContext context) async {
    ProgressDialog.show(context);
    try {
      final response =
          await apiService.get(ApiPath.login, {'mobile_no': phoneNumber});
      final loginResponse = LoginResponse.fromJson(response);
      if (loginResponse.error == null) {
        _responseMessage = loginResponse.message;

        PreferencesServices.setPreferencesData(
          PreferencesServices.isLogin,
          true,
        );
        PreferencesServices.setPreferencesData(
          PreferencesServices.apiToken,
          loginResponse.token ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.astroId,
          loginResponse.astrologer?.astroId ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.fullName,
          loginResponse.astrologer?.fullName ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.mobileNo,
          loginResponse.astrologer?.mobileNo ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.emailId,
          loginResponse.astrologer?.emailId ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.dateOfBirth,
          loginResponse.astrologer?.dateOfBirth ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.profilePhoto,
          loginResponse.astrologer?.profilePhoto ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.astroLivingCity,
          loginResponse.astrologer?.astroLivingCity ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.fullAddress,
          loginResponse.astrologer?.fullAddress ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.pincode,
          loginResponse.astrologer?.pincode ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.gender,
          loginResponse.astrologer?.gender ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.acatId,
          loginResponse.astrologer?.acatId ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.astroSkills,
          loginResponse.astrologer?.astroSkills ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.astroLanguage,
          loginResponse.astrologer?.astroLanguage ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.astroExperience,
          loginResponse.astrologer?.astroExperience ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.astroChatCharge,
          loginResponse.astrologer?.astroChatCharge ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.astroMinuteCharge,
          loginResponse.astrologer?.astroMinuteCharge ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.astroProfileBio,
          loginResponse.astrologer?.astroProfileBio ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.totalCallMinute,
          loginResponse.astrologer?.totalCallMinute ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.totalChatMinute,
          loginResponse.astrologer?.totalChatMinute ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.walletAmount,
          loginResponse.astrologer?.walletAmount ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.astroKyc,
          loginResponse.astrologer?.astroKyc ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.status,
          loginResponse.astrologer?.status ?? '',
        );

        showSuccessSnackBar(context, loginResponse.message!);
        CustomNavigators.pushRemoveUntil(DashboardView(), context);
      } else {
        if (loginResponse.error!.isNotEmpty) {
          if (loginResponse.error!.contains("Quiz")) {
            astro_id = loginResponse.astrologer!.astroId!;
            CustomNavigators.pushReplacementNavigate(
                PreRegisterView(), context);
          } else if (loginResponse.error!.contains("review")) {
            CustomNavigators.pushReplacementNavigate(
                RegisterSuccessScreen(), context);
          } else {
            CustomNavigators.pushReplacementNavigate(RegisterScreen(), context);
          }
          showErrorSnackBar(context, loginResponse.error!);
        }
      }
      ProgressDialog.hide(context);
    } catch (error) {
      ProgressDialog.hide(context);
    } finally {
      ProgressDialog.hide(context);
      notifyListeners();
    }
  }
  clearRegisterData(BuildContext context) {
    final botttomsheet_provider = Provider.of<BottomSheetSelectionProvider>(context, listen: false);

    botttomsheet_provider.selectedastoSkill.clear();
    botttomsheet_provider.selectedastoCat.clear();
    botttomsheet_provider.selectedLanguages.clear();

    name = '';
    email = '';
    dob = '';
    doi = '';
    city = '';
    address = '';
    pincode = '';
    gender = 'Male';
    experience = '';
    chatCharge = '';
    callCharge = '';
    profileBio = '';
    profileImage = '';
    aadharNumber = '';
    aadharFrontPhoto = '';
    aadharBackPhoto = '';
    _quizList = [];
    _languageList = [];
    _skillList = [];
    selected_langauge = [];
    selected_catModel = [];
    selected_Skill = [];
  }


  // Method to verify OTP
  verifyOtp(
      String phoneNumber, String enetred_otp, BuildContext context) async {
    print("helllo" + enetred_otp.toString() + "___" + otp.toString());
    if (enetred_otp == otp) {
      await login(phoneNumber, context);
    } else {
      showErrorSnackBar(context, "Please enter correct otp");
    }
  }

  // Method for registration
  Future<void> register(BuildContext context) async {
    String from_validation = validateForm()!;
    if (from_validation.isEmpty) {
      callRegisterApi(context);
    } else {
      showErrorSnackBar(context, from_validation);
    }
  }

  String? validatequiz() {
    bool hasEmptyAnswer = _quizList.any((quiz) => quiz.answer!.isEmpty);
    if (doi.isEmpty) return "Time of interview required.";
    if (hasEmptyAnswer) {
      return "Please select quiz.";
    }
    return "";
  }

  String? validateForm() {
    // Check if all text fields are filled
    if (name.isEmpty) return "Name is required.";
    if (email.isEmpty) return "Email is required.";
    if (dob.isEmpty) return "Date of birth is required.";
    if (city.isEmpty) return "City is required.";
    if (address.isEmpty) return "Address is required.";
    if (pincode.isEmpty) return "Pincode is required.";
    if (gender.isEmpty) return "Gender is required.";
    if (selected_catModel.length < 1) return "Astrology category is required.";
    if (selected_Skill.length < 1) return "Astrology skills are required.";
    if (selected_langauge.length < 1) return "Languages are required.";
    if (experience.isEmpty) return "Experience is required.";
    if (chatCharge.isEmpty) return "Chat charge is required.";
    if (callCharge.isEmpty) return "Call charge is required.";
    if (profileBio.isEmpty) return "Profile bio is required.";
    if (aadharNumber.isEmpty) return "Aadhar number is required.";

    // Check if photos are uploaded
    if (aadharFrontPhoto == "") return "Aadhar front photo is required.";
    if (aadharBackPhoto == "") return "Aadhar back photo is required.";
    if (profileImage == "") return "Profile photo is required.";

    // Additional specific validations
    if (!isValidEmail(email)) return "Invalid email format.";
    if (dob.isEmpty) return "Please select DOB.";

    // If all validations pass, return null (indicating no error)
    return "";
  }

// Usage:

// Example email validation method

  Future<void> _makeRequest(
      BuildContext context, String endpoint, Map<String, dynamic> body) async {
    notifyListeners();
    ProgressDialog.show(context);
    try {
      final response = await apiService.post(endpoint, body);
      _responseMessage = response['message'];
      _otp = response['otp'].toString();
      startTimer();
      notifyListeners();
      showSuccessSnackBar(context, _responseMessage!);
    } catch (error) {
      _responseMessage = error.toString();
      showSuccessSnackBar(context, _responseMessage!);
    } finally {
      ProgressDialog.hide(context);
      notifyListeners();
    }
  }

  // Update methods for each field
  void updateName(String value) {
    name = value;
    notifyListeners();
  }

  void updateEmail(String value) {
    email = value;
    notifyListeners();
  }

  void updateMobile(String value) {
    mobile_no = value;
    notifyListeners();
  }

  void updateDob(String value) {
    dob = value;
    notifyListeners();
  }

  void updateDoi(String value) {
    doi = value;
    notifyListeners();
  }

  void updateCity(String value) {
    city = value;
    notifyListeners();
  }

  void updateAddress(String value) {
    address = value;
    notifyListeners();
  }

  void updatePincode(String value) {
    pincode = value;
    notifyListeners();
  }

  void updateGender(String value) {
    gender = value;
    notifyListeners();
  }

  void updateExperience(String value) {
    experience = value;
    notifyListeners();
  }

  void updateChatCharge(String value) {
    chatCharge = value;
    notifyListeners();
  }

  void updateCallCharge(String value) {
    callCharge = value;
    notifyListeners();
  }

  void updateProfileBio(String value) {
    profileBio = value;
    notifyListeners();
  }

  void updateAadharNumber(String value) {
    aadharNumber = value;
    notifyListeners();
  }

  // Methods for handling Aadhaar photos
  void uploadAadharFrontPhoto(String filePath) {
    // Logic to upload photo and assign file path
    aadharFrontPhoto = filePath;
    notifyListeners();
  }

  void uploadAadharBackPhoto(String filePath) {
    // Logic to upload photo and assign file path
    aadharBackPhoto = filePath;
    notifyListeners();
  }

  // Fetch User Data
  Future<void> fetchLanguageData() async {
    notifyListeners();
    try {
      final response = await Webservice.fetchData(ApiPath.getLanguages);
      if (response.data != null && response.data.isNotEmpty) {
        _languageList = response.data
            .map<LanguagesModel>((item) => LanguagesModel.fromJson(item))
            .toList();
      } else {
        _languageList = []; // Handle empty or null data
      }
    } catch (e) {
      print('Error fetching user data: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchQuiz() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await Webservice.fetchData(ApiPath.getQuiz);
      if (response.data != null && response.data.isNotEmpty) {
        _quizList = response.data
            .map<AstrologyQuiz>((item) => AstrologyQuiz.fromJson(item))
            .toList();
        for (var i in _quizList) {
          print("_skillList" + i.question.toString());
        }
      } else {
        _quizList = [];
        //  print("geeeeee" + _quizList.length.toString());
      }
      isLoading = false;
    } catch (e) {
      isLoading = false;
      print('Error fetching user data: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchSkills() async {
    notifyListeners();
    try {
      final response = await Webservice.fetchData(ApiPath.getAstroSkills);
      if (response.data != null && response.data.isNotEmpty) {
        _skillList = response.data
            .map<AstrologySkillModel>(
                (item) => AstrologySkillModel.fromJson(item))
            .toList();
        print("_skillList" + _skillList.length.toString());
      } else {
        _skillList = [];
        print("geeeeee" + _skillList.length.toString());
// Handle empty or null data
      }
    } catch (e) {
      print('Error fetching user data: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchCategory() async {
    notifyListeners();
    try {
      final response = await Webservice.fetchData(ApiPath.getAstroCategory);
      if (response.data != null && response.data.isNotEmpty) {
        _categoryList = response.data
            .map<AstrologyCategoryModel>(
                (item) => AstrologyCategoryModel.fromJson(item))
            .toList();
      } else {
        _categoryList = []; // Handle empty or null data
      }
    } catch (e) {
      print('Error fetching user data: $e');
    } finally {
      notifyListeners();
    }
  }
}
