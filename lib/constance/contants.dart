import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';



class MyConst {


  // add your appId and appSign from console

  static int appId = 377637488;

  static String appSign =
      "d506d70b9f3cad7910ad76f4b7fc79d1bf0d0d947d6a2d5682e521c55e873d6a";
  static  String my_name =
      "Astrologer";
  static  bool userPro = false;
  static  bool is_show_pack= true;
  static  bool is_purchased= false;
  static  bool isIOS = Platform.isIOS;
  static String main_device_id = "";
  static int total_user_coins = 0;
  static List<String> stranger_image_list = [];

  static String appName = "QPay";
  static String version = "";
  static late StreamSubscription streamSubscription;
  static bool is_page_open = false;

  static bool showNotificationDialog = false;
  static String subscibed_product_id = "";
  static String subscibed_product_name = "";
  static String subscibed_product_transaction_date = "";
  static String subscibed_product_price = "";
  static String subscibed_product_end_date = "";

 // android
  static String monthly_membership_android = "monthly_subscription";
  static String yearly_membership_android = "yearly_subscription";
  static String lifetime_membership_android = "lifetime_subscription_1";


  //web_view_url
  static String privacy_policy_url = "https://quintustech.in/privacy-policy";
  static String about_us_url = "https://quintustech.in/about";
  static String terms_services_url = "https://quintustech.in/terms-and-condition";

  // android
  static String monthly_membership_ios = "monthly_subscription";
  static String yearly_membership_ios = "yearly_subscription";
  static String lifetime_membership_ios = "lifetime_subscription_1";


  // android gems
  static String gems_100 = "gems_100";
  static String gems_50 = "gems_50";



  static String monthly_membership = "monthly_membership_1";
  static String yearly_membership = "yearly_membership_1";
  static String lifetime_membership = "lifetime_membership_1";



  //for a chat db
  static const String tableName = 'chats';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String textType = 'TEXT NOT NULL';
  static const String intType = 'INTEGER NOT NULL';
  static const String id = '_id';
  static const String msg = 'msg';
  static const String boolType = 'INTEGER NOT NULL';
  static const String fromMe = 'fromMe';
  static const String msgType = 'msgType';
  static const String timestamp = 'timestamp';
  static const String date = 'date';


  static  Map<String, dynamic> main_response = {};


}

