import 'dart:io';

import 'package:astrologeradmin/constance/assets_path.dart';
import 'package:astrologeradmin/constance/my_colors.dart';
import 'package:astrologeradmin/model/Followers.dart';
import 'package:astrologeradmin/model/astro_category_model.dart';
import 'package:astrologeradmin/model/common_response.dart';
import 'package:astrologeradmin/views/dashboard/consultations_view.dart';
import 'package:astrologeradmin/views/dashboard/edit_Bank.dart';
import 'package:astrologeradmin/views/dashboard/edit_profile.dart';
import 'package:astrologeradmin/views/dashboard/home_view.dart';
import 'package:astrologeradmin/views/dashboard/user_view.dart';
import 'package:astrologeradmin/views/dashboard/wallet_view.dart';
import 'package:astrologeradmin/views/video_Call/SearchVideoScreen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../constance/ProgressDialog.dart';
import '../constance/contants.dart';
import '../constance/language/language.dart';
import '../constance/textstyle.dart';
import '../model/AstroBank.dart';
import '../model/AstroEarning.dart';
import '../model/AstroFollowers.dart';
import '../model/AstroProfile.dart';
import '../model/AstrologerRegisterModel.dart';
import '../model/ScheduleData.dart';
import '../model/ScheduleResponse.dart';
import '../model/astro_skill_model.dart';
import '../model/consultation_response.dart';
import '../model/get_languages_model.dart';
import '../model/messageModel.dart';
import '../model/quiz_response.dart';
import '../model/update_consultationModel.dart';
import '../services/ApiService.dart';
import '../services/api_path.dart';
import '../services/user_prefences.dart';
import '../services/web_services.dart';
import '../utils/function_utils.dart';
import '../views/astrologer_chat/Astrologer_Chat.dart';
import '../views/dashboard/consultantion_schedule.dart';
import '../views/dashboard/followers_view.dart';
import '../views/dashboard/support_view.dart';
import '../views/login_screen.dart';
import '../widget/navigators.dart';
import 'LanguageSelectionProvider.dart';

class DashboardProvider extends ChangeNotifier {
  String username = "";
  String profile_image = "";

  int astro_id = 0;
  bool is_Consultation_Schedule = true;
  bool is_duty_on = false;

  String? _responseMessage;

  final value_data = ["00:00 Min.", "00:00 Min.", "₹ 0", "₹ 0"];
  var heading_data = [];

  List<String> iconList = [
    AssetsPath.home,
    AssetsPath.consultationsIc,
    AssetsPath.walletIc,
    AssetsPath.userIc
  ];
  List<String> titleList = [
    'Home',
    'Consultations',
    'Wallet/Earnings',
    'Account'
  ];
  List<Widget> _pagesList = [
    HomePage(),
    ConsultantionView(),
    WalletView(),
    UserView(),
    EditProfile(),
    EditBank(),
    ConsultantionSchedule(),
    FollowersView(),
    SupportView()
  ];

  dutyToggle(BuildContext context, bool value) {
    is_duty_on = value;
    notifyListeners();
    changeDutyStatus(context, value ? 1 : 0);
  }

  Map<String, List<TextEditingController>> day_controllers = {
    'Monday': [TextEditingController()],
    'Tuesday': [TextEditingController()],
    'Wednesday': [TextEditingController()],
    'Thursday': [TextEditingController()],
    'Friday': [TextEditingController()],
    'Saturday': [TextEditingController()],
    'Sunday': [TextEditingController()],
  };

  List<Widget> get pagesList => _pagesList;
  List<String> banner_list = [
    'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/83d70974403181.5c2e97fb1f91b.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScoLSuY7PPYG6_c9_MLzWlF0kAM9A8O4ZgCQ&s',
  ];

  int currentIndex_banner = 0;
  int tabIndex = 0;
  int previous_tab = 0;

  Color selectedColor = secondaryTextColor;
  final ApiService apiService = ApiService();

  List<LanguagesModel> _languageList = [];

  List<LanguagesModel> get languageList => _languageList;

  List<Consultation> _consultationList = [];

  List<EarningData> _earningList = [];

  List<EarningData> get earningList => _earningList;

  List<Consultation> get consultationList => _consultationList;

  List<Consultation> _activeconsultationList = [];

  List<Consultation> get activeconsultationList => _activeconsultationList;

  List<Consultation> _closedconsultationList = [];

  List<Consultation> get closedconsultationList => _closedconsultationList;

  List<AstrologySkillModel> _skillList = [];

  List<AstrologySkillModel> get skillList => _skillList;

  List<AstrologyQuiz> _quizList = [];

  List<AstrologyQuiz> get quizList => _quizList;

  List<AstrologyCategoryModel> _categoryList = [];

  List<AstrologyCategoryModel> get categoryList => _categoryList;

  List<Followers> _followersList = [];

  List<Followers> get followersList => _followersList;

  String bank_name = '';
  String bank_ifsc = '';
  String bank_accountno = '';
  String bank_holdername = '';

  int bank_Ac_approved = 0;
  String bank_Ac_rejected_reason = "";

  String name = '';
  String email = '';
  String dob = '';
  String doi = '';

  String dutyStatus = "False";

  String city = '';
  String address = '';
  int pincode = 0;
  String gender = '';
  String experience = '';
  int chatCharge = 0;
  int callCharge = 0;
  String profileBio = '';
  String profileImage = '';

  String? mobile_no = '';

  int? wallet_amount = 0;

  List<LanguagesModel> selected_langauge = [];
  List<AstrologyCategoryModel> selected_catModel = [];
  List<AstrologySkillModel> selected_Skill = [];

  getDeatils(BuildContext context) async {
    getUserDetails();
    callastroStats(context);
    getConsultationSchedule(context);
    getConsultation(context);
    getActiveConsultation(context);
    getProfile(context);
  }

  void add_day_Field(String day) {
    day_controllers[day]?.add(TextEditingController());
    notifyListeners();
  }

  void setDataOnCardList(BuildContext context) {
    heading_data = [
      Languages.of(context)!.today_chat_min,
      Languages.of(context)!.today_call_min,
      Languages.of(context)!.today_chat_earning,
      Languages.of(context)!.today_call_earning,
    ];
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

  Future<void> UpdateSchedule(BuildContext context) async {
    String from_validation = timeSecheduleFormat()!;
    if (from_validation.isEmpty) {
      callsaveConsultationScheduleAPI(context);
    } else {
      showErrorSnackBar(context, from_validation);
    }
  }

  Future<void> UpdateBankDetails(BuildContext context) async {
    String from_validation = bankForm()!;
    if (from_validation.isEmpty) {
      callUpdateBankAPI(context);
    } else {
      showErrorSnackBar(context, from_validation);
    }
  }

  Future<void> changeDutyStatus(BuildContext context, int duty_status) async {
    Map<String, dynamic> scheduleParams = {"duty_status": duty_status};
    ProgressDialog.show(context);
    try {
      final response =
          await apiService.post_auth(ApiPath.ChangeDutyStatus, scheduleParams);
      final mResponse = CommonResponse.fromJson(response);
      if (mResponse.message != null) {
        showSuccessSnackBar(context, mResponse.message.toString());
      } else {
        showErrorSnackBar(context, "Unknown response message");
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

  Future<void> callsaveConsultationScheduleAPI(BuildContext context) async {
    ProgressDialog.show(context);
    Map<String, dynamic> scheduleParams = {"astro_id": astro_id};
    day_controllers.forEach((day, controllers) {
      // Collect non-empty time slots for each day
      List<String> timeSlots = controllers
          .where((controller) => controller.text.isNotEmpty)
          .map((controller) => controller.text)
          .toList();

      scheduleParams[day.toLowerCase()] = timeSlots;
    });
    try {
      final response = await apiService.post_auth(
          ApiPath.saveConsultationSchedule, scheduleParams);
      final mResponse = CommonResponse.fromJson(response);
      if (mResponse.message != null) {
        showSuccessSnackBar(context, mResponse.message.toString());
      } else {
        showErrorSnackBar(context, "Unknown response message");
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

  Future<void> callUpdateBankAPI(BuildContext context) async {
    Map<String, dynamic> body = {
      "bank_name": bank_name,
      "account_no": bank_accountno,
      "ifsc_code": bank_ifsc,
      "account_holder": bank_holdername
    };
    ProgressDialog.show(context);
    try {
      final response =
          await apiService.post_auth(ApiPath.saveBankDetails, body);
      final mResponse = AstroBank.fromJson(response);

      if (mResponse.message != null) {
        PreferencesServices.setPreferencesData(
            PreferencesServices.adhar_card, mResponse.bank!.adharCard);
        PreferencesServices.setPreferencesData(
            PreferencesServices.bank_name, mResponse.bank!.bankName);
        PreferencesServices.setPreferencesData(
            PreferencesServices.account_no, mResponse.bank!.accountNo);
        PreferencesServices.setPreferencesData(
            PreferencesServices.ifsc_code, mResponse.bank!.ifscCode);
        PreferencesServices.setPreferencesData(
            PreferencesServices.account_holder, mResponse.bank!.accountHolder);
        showSuccessSnackBar(context, mResponse.message.toString());

        getBankDetails();
      } else {
        showErrorSnackBar(context, "Unknown response message");
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

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                PreferencesServices.clearData();
                CustomNavigators.pushRemoveUntil(LoginView(), context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Logged out successfully")),
                );
              },
              child: Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  Future<void> updateProfile(BuildContext context) async {
    String from_validation = validateForm()!;
    if (from_validation.isEmpty) {
      callUpdateProfileAPI(context);
    } else {
      showErrorSnackBar(context, from_validation);
    }
  }

  Future<void> callUpdateProfileAPI(BuildContext context) async {
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
      "astro_profile_bio": profileBio
    };
    ProgressDialog.show(context);
    try {
      final response = await apiService.update_profile(
          ApiPath.updateAstroProfile,
          body,
          profileImage.isEmpty ? null : File(profileImage));
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
          showSuccessSnackBar(context, _responseMessage!!);
        }
        getProfile(context);
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

  String? timeSecheduleFormat() {
    bool allDaysHaveControllers = day_controllers.values.every((controllers) =>
        controllers.every((controller) => controller.text.isNotEmpty));
    if (allDaysHaveControllers) {
      return "";
    } else {
      return ""; // At least one controller has empty text.
    }
  }

  String? bankForm() {
    // Check if all text fields are filled
    if (bank_accountno.isEmpty) return "Bank account number is required.";
    if (!RegExp(r'^\d{9,18}$').hasMatch(bank_accountno)) {
      return "Bank account number must be 9 to 18 digits.";
    }

    if (bank_holdername.isEmpty) return "Account holder name is required.";
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(bank_holdername)) {
      return "Account holder name can only contain alphabets and spaces.";
    }

    if (bank_ifsc.isEmpty) return "IFSC code is required.";
    if (!RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$').hasMatch(bank_ifsc)) {
      return "Invalid IFSC code format.";
    }

    if (bank_name.isEmpty) return "Bank name is required.";
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(bank_name)) {
      return "Bank name can only contain alphabets and spaces.";
    }

    return ""; // Return null if all validations pass
  }

  String? validateForm() {
    // Check if all text fields are filled
    if (name.isEmpty) return "Name is required.";
    if (email.isEmpty) return "Email is required.";
    if (dob.isEmpty) return "Date of birth is required.";
    if (city.isEmpty) return "City is required.";
    if (address.isEmpty) return "Address is required.";
    if (gender.isEmpty) return "Gender is required.";
    if (selected_catModel.length < 1) return "Astrology category is required.";
    if (selected_Skill.length < 1) return "Astrology skills are required.";
    if (selected_langauge.length < 1) return "Languages are required.";
    if (experience.isEmpty) return "Experience is required.";
    if (profileBio.isEmpty) return "Profile bio is required.";
    if (pincode.toString().length != 6) return "Enter valid pincode";
    if (chatCharge.toString().isEmpty) return "Enter chat charge";
    if (chatCharge < 1) return "Enter valid chat charge";
    if (callCharge.toString().isEmpty) return "Enter call charge";
    if (callCharge < 1) return "Enter valid call charge";

    // Additional specific validations
    if (!isValidEmail(email)) return "Invalid email format.";
    if (dob.isEmpty) return "Please select DOB.";

    // If all validations pass, return null (indicating no error)
    return "";
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImage = image!.path.toString();
      notifyListeners();
    }
  }

  // Update methods for each field
  void updateName(String value) {
    name = value;
    notifyListeners();
  }

  void updateBankName(String value) {
    bank_name = value;
    notifyListeners();
  }

  void updateBankIfsc(String value) {
    bank_ifsc = value;
    notifyListeners();
  }

  void updateBankAccount(String value) {
    bank_accountno = value;
    notifyListeners();
  }

  void updateBankHolder(String value) {
    bank_holdername = value;
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
    pincode = int.parse(value);
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
    try {
      chatCharge = int.parse(value);
    } catch (e) {
      chatCharge = 0;
    }
    notifyListeners();
  }

  void updateCallCharge(String value) {
    try {
      callCharge = int.parse(value);
    } catch (e) {
      callCharge = 0;
    }
    notifyListeners();
  }

  void updateProfileBio(String value) {
    profileBio = value;
    notifyListeners();
  }

  Future<void> fetchQuiz() async {
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
    } catch (e) {
      print('Error fetching user data: $e');
    } finally {
      notifyListeners();
    }
  }

  Widget buildCategoryHalfWidthDropdownField(
    BuildContext context,
    String label,
    String hintText,
    Function(List<AstrologyCategoryModel>) onChanged,
    List<AstrologyCategoryModel> selectedValues,
    List<AstrologyCategoryModel> items,
    DashboardProvider provider,
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
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: lightGrey, width: 0.6),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
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

  void _showCategorySelectionBottomSheet(
    BuildContext context,
    List<AstrologyCategoryModel> items,
  ) {
    final provider =
        Provider.of<BottomSheetSelectionProvider>(context, listen: false);

    if (provider.selectedastoCat.length < 1) {
      provider.selectedastoCat.addAll(selected_catModel);
    }

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

  Widget buildLanguageHalfWidthDropdownField(
    BuildContext context,
    String label,
    String hintText,
    Function(List<LanguagesModel>) onChanged,
    List<LanguagesModel> selectedValues,
    List<LanguagesModel> items,
    DashboardProvider provider,
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
              height: 55,
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: lightGrey, width: 0.6),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
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
                    provider.setAllLang(selected_langauge);
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

  void _showSkillSelectionBottomSheet(
    BuildContext context,
    List<AstrologySkillModel> items,
  ) {
    final provider =
        Provider.of<BottomSheetSelectionProvider>(context, listen: false);
    if (provider.selectedastoSkill.length < 1) {
      provider.selectedastoSkill.addAll(selected_Skill);
    }
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

  Widget buildSkillHalfWidthDropdownField(
    BuildContext context,
    String label,
    String hintText,
    Function(List<AstrologySkillModel>) onChanged,
    List<AstrologySkillModel> selectedValues,
    List<AstrologySkillModel> items,
    DashboardProvider provider,
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
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: lightGrey, width: 0.6),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
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

  getBankDetails() async {
    bank_name = await PreferencesServices.getPreferencesData(
        PreferencesServices.bank_name);
    bank_ifsc = await PreferencesServices.getPreferencesData(
        PreferencesServices.ifsc_code);
    bank_holdername = await PreferencesServices.getPreferencesData(
        PreferencesServices.account_holder);
    bank_accountno = await PreferencesServices.getPreferencesData(
        PreferencesServices.account_no);
    notifyListeners();
  }

  getUserDetails() async {
    username = await PreferencesServices.getPreferencesData(
        PreferencesServices.fullName);
    profile_image = await PreferencesServices.getPreferencesData(
        PreferencesServices.profilePhoto);
    astro_id = await PreferencesServices.getPreferencesData(
        PreferencesServices.astroId);
    name = await PreferencesServices.getPreferencesData(
        PreferencesServices.fullName);
    email = await PreferencesServices.getPreferencesData(
        PreferencesServices.emailId);
    dob = await PreferencesServices.getPreferencesData(
        PreferencesServices.dateOfBirth);
    city = await PreferencesServices.getPreferencesData(
        PreferencesServices.astroLivingCity);
    address = await PreferencesServices.getPreferencesData(
        PreferencesServices.fullAddress);
    pincode = await PreferencesServices.getPreferencesData(
        PreferencesServices.pincode);
    gender = await PreferencesServices.getPreferencesData(
        PreferencesServices.gender);
    experience = await PreferencesServices.getPreferencesData(
        PreferencesServices.astroExperience);
    chatCharge = await PreferencesServices.getPreferencesData(
        PreferencesServices.astroChatCharge);
    callCharge = await PreferencesServices.getPreferencesData(
        PreferencesServices.astroMinuteCharge);
    profileBio = await PreferencesServices.getPreferencesData(
        PreferencesServices.astroProfileBio);
    mobile_no = await PreferencesServices.getPreferencesData(
        PreferencesServices.mobileNo);

    wallet_amount = await PreferencesServices.getPreferencesData(
        PreferencesServices.walletAmount);

    setDataInList();
    notifyListeners();
    MyConst.my_name = username;
  }

  setDataInList() async {
    String astro_lng = await PreferencesServices.getPreferencesData(
        PreferencesServices.astroLanguage);
    List<int> intList_lng = astro_lng
        .replaceAll(RegExp(r'[\[\]\s]'), '') // Remove brackets and spaces
        .split(',') // Split by commas
        .map(int.parse) // Convert each string to an integer
        .toList();
    selected_langauge = languageList
        .where((language) => intList_lng.contains(language.langId))
        .toList();

    String astro_skill = await PreferencesServices.getPreferencesData(
        PreferencesServices.astroSkills);
    List<int> intList_skill = astro_skill
        .replaceAll(RegExp(r'[\[\]\s]'), '') // Remove brackets and spaces
        .split(',') // Split by commas
        .map(int.parse) // Convert each string to an integer
        .toList();
    selected_Skill = skillList
        .where((skill) => intList_skill.contains(skill.skill_id))
        .toList();

    int astro_cat = await PreferencesServices.getPreferencesData(
        PreferencesServices.acatId);
    List<int> intList_car = astro_cat
        .toString()
        .replaceAll(RegExp(r'[\[\]\s]'), '') // Remove brackets and spaces
        .split(',') // Split by commas
        .map(int.parse) // Convert each string to an integer
        .toList();
    selected_catModel =
        categoryList.where((cat) => intList_car.contains(cat.acatId)).toList();
    notifyListeners();
  }

  callastroStats(BuildContext context) async {
    try {
      final response = await apiService.getAuth(ApiPath.astroStats, {});
      final mResponse = CommonResponse.fromJson(response);
      if (mResponse.error != null) {
        if (mResponse.data != null && mResponse.data is Map<String, dynamic>) {
          value_data[0] = mResponse.data['TodayChatMinute'];
          value_data[1] = mResponse.data['todayCallMinute'];
          value_data[2] = mResponse.data['todayChatEarn'];
          value_data[3] = mResponse.data['todayCallEarn'];
        }
      } else {}
    } catch (error) {
    } finally {
      notifyListeners();
    }
  }

  getWithdrwalRequest(BuildContext context, String requested_amount) async {
    try {
      final response = await apiService.post_auth(
          ApiPath.withdrawlRequest, {"request_amount": requested_amount});
      final mResponse = CommonResponse.fromJson(response);
      if (mResponse.message != null) {
        getProfile(context);
        getEarningHistory(context);
        notifyListeners();
        Fluttertoast.showToast(msg: mResponse.message.toString());
      } else {
        Fluttertoast.showToast(msg: mResponse.error.toString());
      }
    } catch (error) {
    } finally {
      notifyListeners();
    }
  }

  getEarningHistory(BuildContext context) async {
    try {
      final response = await apiService.getAuth(ApiPath.getEarningHistory, {});
      final mResponse = EarningHistory.fromJson(response);
      if (mResponse.message != null) {
        _earningList = mResponse.data;
      } else {}
    } catch (error) {
      showSuccessSnackBar(context, "mResponse.message!" + error.toString());
    } finally {
      notifyListeners();
    }
  }

  getBankAccountAPI(BuildContext context) async {
    try {
      final response = await apiService.getAuth(ApiPath.getBankDetails, {});
      final mResponse = AstroBank.fromJson(response);
      if (mResponse.message != null) {
        bank_Ac_approved = mResponse.bank!.status!;
        bank_Ac_rejected_reason = mResponse.bank!.reason!;
        PreferencesServices.setPreferencesData(
            PreferencesServices.adhar_card, mResponse.bank!.adharCard);
        PreferencesServices.setPreferencesData(
            PreferencesServices.bank_name, mResponse.bank!.bankName);
        PreferencesServices.setPreferencesData(
            PreferencesServices.account_no, mResponse.bank!.accountNo);
        PreferencesServices.setPreferencesData(
            PreferencesServices.ifsc_code, mResponse.bank!.ifscCode);
        PreferencesServices.setPreferencesData(
            PreferencesServices.account_holder, mResponse.bank!.accountHolder);
        getBankDetails();
      } else {}
    } catch (error) {
    } finally {
      notifyListeners();
    }
  }

  getProfile(BuildContext context) async {
    try {
      final response = await apiService.getAuth(ApiPath.getProfile, {});
      final mResponse = AstroProfile.fromJson(response);
      if (mResponse.message != null) {
        PreferencesServices.setPreferencesData(
          PreferencesServices.astroId,
          mResponse.user?.astroId ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.fullName,
          mResponse.user?.fullName ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.mobileNo,
          mResponse.user?.mobileNo ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.emailId,
          mResponse.user?.emailId ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.dateOfBirth,
          mResponse.user?.dateOfBirth ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.profilePhoto,
          mResponse.user?.profilePhoto ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.astroLivingCity,
          mResponse.user?.astroLivingCity ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.fullAddress,
          mResponse.user?.fullAddress ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.pincode,
          mResponse.user?.pincode ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.gender,
          mResponse.user?.gender ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.acatId,
          mResponse.user?.acatId ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.astroSkills,
          mResponse.user?.astroSkills ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.astroLanguage,
          mResponse.user?.astroLanguage ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.astroExperience,
          mResponse.user?.astroExperience ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.astroChatCharge,
          mResponse.user?.astroChatCharge ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.astroMinuteCharge,
          mResponse.user?.astroMinuteCharge ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.astroProfileBio,
          mResponse.user?.astroProfileBio ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.totalCallMinute,
          mResponse.user?.totalCallMinute ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.totalChatMinute,
          mResponse.user?.totalChatMinute ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.walletAmount,
          mResponse.user?.walletAmount ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.astroKyc,
          mResponse.user?.astroKyc ?? '',
        );

        PreferencesServices.setPreferencesData(
          PreferencesServices.status,
          mResponse.user?.status ?? '',
        );
        getUserDetails();
      } else {}
    } catch (error) {
    } finally {
      notifyListeners();
    }
  }

  Future<void> getDutyStatus(BuildContext context) async {
    try {
      final response = await apiService.getAuth(ApiPath.getDutyStatus, {});
      if (response != null && response is Map<String, dynamic>) {
        dutyStatus = response['Duty Status'];
        is_duty_on = response['duty_status'] == "1" ? true : false;
      } else {}
    } catch (error) {
    } finally {
      notifyListeners();
    }
  }

  getFollowers(BuildContext context) async {
    ProgressDialog.show(context);
    try {
      final response = await apiService.getAuth(ApiPath.getMyFollowers, {});
      final mResponse = AstroFollowers.fromJson(response);
      if (mResponse.message != null) {
        _followersList = mResponse.followers!;
      } else {}
    } catch (error) {
    } finally {
      ProgressDialog.hide(context);
      notifyListeners();
    }
  }


  updateConsultation(BuildContext context, String mstatus, int con_id,
      int consultation_type, String duration, int charge_amount) async {
    try {
      final response = await apiService.post_auth(ApiPath.updateConsultation, {
        "status": mstatus,
        "con_id": con_id,
        "duration": duration,
        "charge_amount": charge_amount,
        "consultation_type": consultation_type
      });
      final mResponse = UpdateConsultationModel.fromJson(response);
      if (mResponse.message != null) {
        if (mstatus == "3") {
          if (consultation_type == 2) {
            CustomNavigators.pushNavigate(
                SearchAnimationScreen(mconsultationData: mResponse.data!),
                context);
          } else {
            // print("neeeeeeee"+mResponse.data!.fullName!);
            CustomNavigators.pushNavigate(
                AstrologerChat(mconsultationData: mResponse.data!), context);
          }
        } else if (mstatus == "4") {
          DatabaseReference databaseReference = FirebaseDatabase.instance
              .ref()
              .child(consultation_type == 2?"room_call":"astro_chat")
              .child(con_id.toString());
          if(consultation_type!=2) {
            try {
              MessageModel messageModel = MessageModel(
                message: "",
                messanger_name: "",
                user_id: "astro_" + "878",
              );
              await databaseReference
                  .child("chathistory")
                  .push()
                  .set(messageModel.toJson());
            } catch (error) {
              debugPrint("Failed to send message: $error");
            }
          }
          databaseReference.remove();
        } else {
          showSuccessSnackBar(context, mResponse.message!);
        }
        getDeatils(context);
      }
    } catch (error) {
    } finally {
      notifyListeners();
    }
  }

  getClosedConsultation(BuildContext context) async {
    try {
      final response = await apiService
          .post_auth(ApiPath.getConsultation, {"statusType": "2"});
      final mResponse = ConsultationResponse.fromJson(response);
      if (mResponse.error != null) {
        _closedconsultationList = mResponse.data!;
      } else {}
    } catch (error) {
    } finally {
      notifyListeners();
    }
  }

  getActiveConsultation(BuildContext context) async {
    try {
      final response = await apiService
          .post_auth(ApiPath.getConsultation, {"statusType": "3"});
      final mResponse = ConsultationResponse.fromJson(response);
      if (mResponse.error != null) {
        _activeconsultationList = mResponse.data!;
      } else {}
    } catch (error) {
    } finally {
      notifyListeners();
    }
  }

  getConsultation(BuildContext context) async {
    try {
      final response = await apiService
          .post_auth(ApiPath.getConsultation, {"statusType": "1"});
      final mResponse = ConsultationResponse.fromJson(response);
      if (mResponse.error != null) {
        _consultationList = mResponse.data!;
      } else {}
    } catch (error) {
    } finally {
      notifyListeners();
    }
  }

  void populateDayControllersFromModel(ScheduleData scheduleData) {
    Map<String, String?> modelDays = {
      'Monday': scheduleData.monday,
      'Tuesday': scheduleData.tuesday,
      'Wednesday': scheduleData.wednesday,
      'Thursday': scheduleData.thursday,
      'Friday': scheduleData.friday,
      'Saturday': scheduleData.saturday,
      'Sunday': scheduleData.sunday,
    };
    modelDays.forEach((day, timeSlotsString) {
      if (timeSlotsString != null) {
        // Remove brackets and split the time slots
        String cleanedSlots = timeSlotsString.replaceAll(RegExp(r'[\[\]]'), '');
        List<String> timeSlots =
            cleanedSlots.split(',').map((slot) => slot.trim()).toList();

        // Populate TextEditingControllers for the day
        day_controllers[day] = timeSlots
            .map((slot) => TextEditingController()..text = slot)
            .toList();
      }
    });
    notifyListeners();
  }

  getConsultationSchedule(BuildContext context) async {
    try {
      final response =
          await apiService.getAuth(ApiPath.getConsultationSchedule, {});
      final mResponse = ScheduleResponse.fromJson(response);
      if (mResponse.error != null) {
        is_Consultation_Schedule = mResponse.data != null;
        populateDayControllersFromModel(mResponse.data![0]);
      } else {
        is_Consultation_Schedule = false;
      }
    } catch (error) {
      is_Consultation_Schedule = false;
    } finally {
      notifyListeners();
    }
  }

  changeTab(int index) {
    previous_tab = tabIndex;
    tabIndex = index;
    notifyListeners();
  }

  tabOnTap(int index) {
    previous_tab = tabIndex;
    tabIndex = index;
    if (tabIndex == index) {
      selectedColor = secondaryTextColor;
    } else {
      selectedColor = lightText;
    }
    notifyListeners();
  }

  changeBannerIndex(int index) {
    currentIndex_banner = index;
    notifyListeners();
  }
}
