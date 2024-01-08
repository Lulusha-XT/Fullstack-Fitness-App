import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LangugeServices {
  final _boxs = GetStorage();
  final _key = 'languge';
  _saveLangugeToBox(String isAmharic) => _boxs.write(_key, isAmharic);

  String _loadLangugeFromBox() {
    return _boxs.read(_key) ?? "et";
  }

  Locale get local => _loadLangugeFromBox() == "et"
      ? const Locale('et', 'ET')
      : _loadLangugeFromBox() == "en"
          ? const Locale('en', 'US')
          : _loadLangugeFromBox() == "tg"
              ? const Locale('et', 'TG')
              : const Locale('et', 'OR');

  void switchLanguge(Locale languge) {
    if (languge == const Locale('et', 'ET')) {
      _saveLangugeToBox("et");
    } else if (languge == const Locale('en', 'US')) {
      _saveLangugeToBox("en");
    } else if (languge == const Locale('et', 'TG')) {
      _saveLangugeToBox("tg");
    } else {
      _saveLangugeToBox("or");
    }
  }
}
