
import 'package:astrologeradmin/constance/language/language.dart';
import 'package:astrologeradmin/constance/language/language_en.dart';
import 'package:astrologeradmin/constance/language/language_hi.dart';
import 'package:flutter/cupertino.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages>{

  AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en',"hi"].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  @override
  bool shouldReload(covariant LocalizationsDelegate<Languages> old) => false;

  Future<Languages> _load(Locale locale) async{
    switch (locale.languageCode){
      case 'en':
      return LanguageEn();
      case 'hi':
        return LanguageHi();
      default:
        return LanguageEn();
    }
  }


}