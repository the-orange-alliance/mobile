import 'dart:async';
import 'package:flutter/material.dart';
import 'package:toa_flutter/internationalization/Localizations.dart';

class TOALocalizationsDelegate extends LocalizationsDelegate<TOALocalizations> {
  const TOALocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'he'].contains(locale.languageCode);

  @override
  Future<TOALocalizations> load(Locale locale) async {
    TOALocalizations localizations = TOALocalizations(locale);
    await localizations.load();

    print("Load ${locale.languageCode}");

    return localizations;
  }

  @override
  bool shouldReload(TOALocalizationsDelegate old) => false;
}
