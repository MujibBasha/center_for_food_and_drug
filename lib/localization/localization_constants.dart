import 'package:center_for_food_and_drug/localization/demo_localization.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String getTranslated({BuildContext context, String key, String typeScreen}) {
  return DemoLocalization.of(context)
      .getTranslatedValue(typeScreen: typeScreen, key: key);
}

const String ENGLISH = "en";
const String ARABIC = "ar";

const String LANGUAGE_CODE = "languageCode";

Future setLocalePref(String languageCode) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setString(LANGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  Locale _temp;

  switch (languageCode) {
    case ENGLISH:
      _temp = Locale(languageCode, "US");
      break;
    case ARABIC:
      _temp = Locale(languageCode, "SA");
      break;
    default:
      _temp = Locale("en", "US");
  }

  return _temp;
}

Future getLocalePref() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String languageCode = pref.getString(LANGUAGE_CODE) ?? ENGLISH;

  return _locale(languageCode);
}
