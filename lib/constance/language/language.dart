import 'package:flutter/cupertino.dart';

abstract class Languages {
  static Languages ? of(BuildContext context){
    return Localizations.of<Languages>(context, Languages);
  }


  String get update_schedule;
  String get consulation_schedule_text;
  String get consultation_Schedule;
  String get appName ;
  String get aiAstrology;
  String get aiAstrologyS;
  String get findCompleteSolutionToYourProblems;
  String get exploreNowToExperience;
  String get loremIpsum;
  String get getStarted;
  String get pickYourPreferredLanguage;
  String get loginToAiAstrology;
  String get consultHundredsOfExpert;
  String get otpVerification;
  String get enterOtpWhichhas;
  String get phoneNumber;
  String get enterYourMobileNumber;
  String get enterYourvalidMobileNumber;
  String get bySigningUpYouAgree;

  String get registerAccount;
  String get yourAccountNotRegistered;
  String get fullName;
  String get enterFullName;
  String get emailAddress;
  String get enterEmailAddress;
  String get dateOfBirth;
  String get currentCity;
  String get enterCurrentCity;
  String get currentFullAddress;
  String get enterFullAddress;
  String get pincode;
  String get enterPincode;

  String get gender;
  String get selectGender;
  String get chatChargePerMin;
  String get callChargePerMin;


  String get astro_Exper_cat;
  String get adhar_back_photo;
  String get adhar_front_photo;
  String get adhar_card_number;
  String get enter_adhar_card_number;

  String get exitAppTitle;
  String get exitAppMessage;

  String get astor_profile_bio;
  String get astor_profile_bio_detail;
  String get enter_charge;

  String get exp_in_year;
  String get enter_exp;

  String get language_know;
  String get astro_skills;
  String get type_skill_name;


  String get termsAndConditions;
  String get privacyPolicy;
  String get and;
  String get privateAndConfidential;
  String get verifiedAstrologers;
  String get verify;
  String get securePayments;
  String get sendOTP;
  String get hazzle_free_service;
  String get preRegistrationScreeningQuiz;
  String get astrologerNeedToComplete;
  String get howManyTotalRashisInVedicAstrology;
  String get suggestTimeForYourInterview;
  String get beforeStartUsingThisPlatform;
  String get audioVideoCall;
  String get activeConsultation;
  String get consultationRequests;
  String get welcome;
  String get letStartSolvingPeoplesProblem;
  String get dutyOnOff;
  String get consultationScheduleNotUpdated;
  String get reject;
  String get accept;
  String get rejoin;
  String get endConsultation;
  String get viewPartnerDetails;

  String get consultation_history;
  String get detail_consultation_transaction;
  String get date_time;
  String get bank_details_kyc;
  String get these_bank_details;
  String get kyc_rejected;
  String get update_bank_details;

  String get bank_name;
  String get enter_bank_name;

  String get bank_ifsc_code;
  String get enter_bank_ifsc_code;

  String get account_number;
  String get enter_account_number;

  String get account_holder_name;
  String get bank_account_holder_name;

  String get update_account_details;
  String get my_followers;

  String get list_of_customer_following_you;

  String get following_from;

  String get start_solving_people_problem;

  String get need_help;
  String get connect_with_us_available_options;
  String get start_live_chat;
  String get connect_through_chat_resolve_issue;
  String get call_us;
  String get connect_with_one_of_our_support_executives;

  String get mail_us;

  String get get_call_back_from_executive;

  String get today_chat_min;
  String get today_call_min;
  String get today_chat_earning;
  String get today_call_earning;

  String get personalProfile ;

  String get bankDetails ;

  String get consultationSchedule ;

  String get wallet ;

  String get consultationHistory;

  String get myFollowers ;

  String get language ;

  String get english;

  String get helpCenter ;

  String get privacyPolicies;

  String get refundPolicies ;

  String get aboutAiAstrology ;


  String get logout;




  String get myWalletBalance => "My Wallet Balance";


  String get withdrawBalance => "Withdraw Balance";


  String get walletHistory => "Wallet History";


  String get walletTransactionsData => "Wallet Transactions Data";


  String get earnings => "Earnings";


  String get withdrawals => "Withdrawals";


  String get notReceivedYet => "Not Received Yet?";


  String get resend_in => "Resend in";

  String get resend_otp => "Resend OTP";

  String get account_under_Review;

  String get withdraw_wallet_balance;

  String get enterAmountTowithdraw;

  String get sendRequest;

  String get pleaseEnterValidAmount;
  String get pleaseEnterAmount;

  String get enterAmount;

  String get welcome_to_aiAstro;

  String get dob;

  String get partner_name;
  String get partner_dob;
  String get partner_address;

  String get doyou_want_exit ;

  String get no ;
  String get yes ;
  String get exit ;
  String get are_your_sure_exit_chat ;
  String get end_consultation ;
  String get paid_minute ;
  String get dob_short ;

  String get end_consultation_description ;
  String get cancel ;




}