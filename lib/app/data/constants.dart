import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConstants{
  static const String appName = 'Robua';
  static const String appTagLine = 'Robua';
  static const String appVersion = '1.0.0';
  static const String appFontFamily = 'almarai';
  static const FontWeight semiBold = FontWeight.w400;
  static const FontWeight bold = FontWeight.w900;
  static String? userLang;
static String? userToken;





  static loadUserFromCache() async {
    final prefs = await SharedPreferences.getInstance();
//user_lang
    final userLang = prefs.getString('user_lang');
    if (userLang != null) {

      AppConstants.userLang =  userLang;


      print('User Lang loaded from cache: $userLang');
    }


  }

}