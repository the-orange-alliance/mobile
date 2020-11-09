import 'dart:async';

import 'package:flutter/material.dart';

import './localizations.dart';

class TOALocalizationsDelegate extends LocalizationsDelegate<TOALocalizations> {
  const TOALocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'he', 'es'].contains(locale.languageCode);

  @override
  Future<TOALocalizations> load(Locale locale) async {
    TOALocalizations localizations = TOALocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(TOALocalizationsDelegate old) {
    return true;
  }
}