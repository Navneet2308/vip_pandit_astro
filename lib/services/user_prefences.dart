import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesServices {
  static String registerUserIdentityDetails = "RegisterUserIdentityDetails";
  static String loginUserIdentityDetails = "LoginUserIdentityDetails";
  static String deviceId = "deviceId";
  static String deviceType = "deviceType";
  static String isLogin = "isLogin";
  static String fcm = "FCM";
  static String parentId = "ParentId";


  static String apiToken = "apiToken";
  static String astroId = "astroId";
  static String fullName = "fullName"; // Default value is the variable name
  static String mobileNo = "mobileNo"; // Default value is the variable name
  static String emailId = "emailId"; // Default value is the variable name
  static String dateOfBirth = "dateOfBirth"; // Default value is the variable name
  static String profilePhoto = "profilePhoto"; // Default value is the variable name
  static String astroLivingCity = "astroLivingCity"; // Default value is the variable name
  static String fullAddress = "fullAddress"; // Default value is the variable name
  static String pincode = "pincode"; // Default value is the variable name
  static String gender = "gender"; // Default value is the variable name
  static String acatId = "acatId"; // Default value is the variable name
  static String astroSkills = "astroSkills"; // Default value is the variable name
  static String astroLanguage = "astroLanguage"; // Default value is the variable name
  static String astroExperience = "astroExperience"; // Default value is the variable name
  static String astroChatCharge = "astroChatCharge"; // Default value is the variable name
  static String astroMinuteCharge = "astroMinuteCharge"; // Default value is the variable name
  static String astroProfileBio = "astroProfileBio"; // Default value is the variable name
  static String totalCallMinute = "totalCallMinute"; // Default value is the variable name
  static String totalChatMinute = "totalChatMinute"; // Default value is the variable name
  static String walletAmount = "walletAmount"; // Default value is the variable name
  static String astroKyc = "astroKyc"; // Default value is the variable name
  static String status = "status"; // Default value is the variable name

  static String adhar_card = "adhar_card";
  static String bank_name = "bank_name";
  static String account_no = "account_no";
  static String ifsc_code = "ifsc_code";
  static String account_holder = "account_holder";




  ///..... SharePrefences save data ........
  static void setPreferencesData(String key, dynamic data) async {
    final prefences = await SharedPreferences.getInstance();
    if (data is String) {
      prefences.setString(key, data);
    } else if (data is int) {
      prefences.setInt(key, data);
    } else if (data is bool) {
      prefences.setBool(key, data);
    } else if (data is double) {
      prefences.setDouble(key, data);
    } else {
      debugPrint("Invalid datatype");
    }
  }

  static Future<dynamic> getPreferencesData(String key) async {
    final preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey(key)) {
      // Try to determine the type of the stored data
      dynamic data = preferences.get(key);
      return data;
    } else {
      debugPrint("Key not found");
      return null;
    }
  }

  static void setLogoutPreferencesData(){
    setPreferencesData(isLogin, false);
    setPreferencesData(apiToken,"");
  }


  ///---------------------Delete Data------------------------

  static Future<bool> deleteData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }


  ///---------------------Clear all Data------------------------

  static Future clearData() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }


}
