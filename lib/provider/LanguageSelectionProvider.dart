import 'package:astrologeradmin/model/astro_category_model.dart';
import 'package:astrologeradmin/model/astro_skill_model.dart';
import 'package:flutter/cupertino.dart';

import '../model/get_languages_model.dart';

class BottomSheetSelectionProvider extends ChangeNotifier {
  List<LanguagesModel> _selectedLanguages = [];
  List<LanguagesModel> get selectedLanguages => _selectedLanguages;

  List<AstrologyCategoryModel> _selectedastoCat = [];
  List<AstrologyCategoryModel> get selectedastoCat => _selectedastoCat;

  List<AstrologySkillModel> _selectedastoSkill = [];
  List<AstrologySkillModel> get selectedastoSkill => _selectedastoSkill;



  void toggleLanguage(LanguagesModel language) {
    if (_selectedLanguages.contains(language)) {
      _selectedLanguages.remove(language);
    } else {
      _selectedLanguages.add(language);
    }
    notifyListeners();
  }


  void setAllLang(List<LanguagesModel> selected_langauge)
  {

  }

  void toggleCategory(AstrologyCategoryModel asto_cat) {
    if (_selectedastoCat.contains(asto_cat)) {
      _selectedastoCat.remove(asto_cat);
    } else {
      _selectedastoCat.add(asto_cat);
    }
    notifyListeners();
  }


  void toggleSkill(AstrologySkillModel asto_skill) {
    if (_selectedastoSkill.contains(asto_skill)) {
      _selectedastoSkill.remove(asto_skill);
    } else {
      _selectedastoSkill.add(asto_skill);
    }
    notifyListeners();
  }


}
