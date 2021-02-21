import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class DemoLocalization {
  final Locale locale;
  DemoLocalization(this.locale);

  static DemoLocalization of(BuildContext context) {
    return Localizations.of<DemoLocalization>(context, DemoLocalization);
  }

// static Map<String, Map<String, String>> _localizedValues;
  //  Map<String, String>
  dynamic _localizedValues;

  Future load() async {
    String jsonStringValues =
        await rootBundle.loadString("lib/lang/${locale.languageCode}.json");

    //Map<String, dynamic> mappedJson = json.decode(jsonStringValues);

    _localizedValues = jsonDecode(jsonStringValues);
    //.map(
    //       (key, value) => MapEntry(
    //         key,
    //         value.toString(),
    //       ),
    //     );
  }

  String getTranslatedValue({
    String key,
    String typeScreen,
  }) {
    return _localizedValues[typeScreen][key]; //[typeScreen][section][key]
  }

  static const LocalizationsDelegate<DemoLocalization> delegate =
      _DemoLocalizationsDelegate();
}

class _DemoLocalizationsDelegate
    extends LocalizationsDelegate<DemoLocalization> {
  const _DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ["en", "ar"].contains(locale.languageCode);
  }

  @override
  Future<DemoLocalization> load(Locale locale) async {
    DemoLocalization localization = new DemoLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(_DemoLocalizationsDelegate old) => false;
}
