import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageChange with ChangeNotifier {
  Locale? _appLocale;
  Locale? get appLocale => _appLocale;

  LanguageChange() {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? languageCode = sp.getString('language_code');
    if (languageCode != null) {
      _appLocale = Locale(languageCode);
      notifyListeners();
    }
  }

  void changeLang(Locale type) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (type == Locale('en')) {
      _appLocale = type;
      await sp.setString('language_code', 'en');
    } else {
      _appLocale = Locale('hi');
      await sp.setString('language_code', 'hi');
    }
    log(sp.getString('language_code').toString());
    notifyListeners();
  }
}
