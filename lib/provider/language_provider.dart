import 'package:astrologeradmin/constance/language/constant.dart';
import 'package:astrologeradmin/model/get_languages_model.dart';
import 'package:astrologeradmin/services/web_services.dart';
import 'package:astrologeradmin/views/login_screen.dart';
import 'package:astrologeradmin/widget/navigators.dart';
import 'package:flutter/material.dart';

class LanguageNotifier extends ChangeNotifier {
  String? _selectedLanguage;
  Locale? _locale;
  String? get selectedLanguage => _selectedLanguage;

  void selectLanguage(String language,BuildContext context,String languageCode) {
    _selectedLanguage = language;
    changeLanguage(context,languageCode);
    setLocale(languageCode);
    notifyListeners();

  }
  void getLanguage() {
    getLocale().then((locale) {
        _locale = locale;
      if(_locale.toString() == "en"){
        _selectedLanguage = 'English';
      }else{
        _selectedLanguage= 'Hindi';
      }
      notifyListeners();
    });
  }

}
