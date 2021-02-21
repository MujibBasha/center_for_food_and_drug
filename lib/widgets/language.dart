import 'package:flutter/material.dart';

class Language {
  final int id;
  final String name;
  final String flag;
  final languageCode;
  Language({
    this.id,
    this.name,
    this.flag,
    this.languageCode,
  });

  static List<Language> languageList = [
    Language(
      id: 1,
      name: "English",
      flag: "🇺🇸",
      languageCode: "en",
    ),
    Language(
      id: 2,
      name: "العربية",
      flag: "🇸🇦",
      languageCode: "ar",
    ),
  ];
}
