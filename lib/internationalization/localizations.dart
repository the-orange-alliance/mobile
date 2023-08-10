import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TOALocalizations {
  TOALocalizations(this.locale);

  final Locale locale;

  static TOALocalizations? of(BuildContext context) {
    return Localizations.of<TOALocalizations>(context, TOALocalizations);
  }

  Map<String, dynamic>? english;
  Map<String, dynamic>? translations;

  Future<bool> load() async {
    String data = await rootBundle.loadString(
        'assets/lang/${this.locale.languageCode}.json');
    this.translations = json.decode(data);

    // Default strings
    if (this.locale.languageCode == 'en') {
      this.english = json.decode(data);
    } else {
      String data = await rootBundle.loadString('assets/lang/en.json');
      this.english = json.decode(data);
    }

    return true;
  }

  String get(String key, {bool english = false, String? defaultValue}) {
    if (defaultValue == null) {
      defaultValue = key;
    }

    dynamic value = english ? this.english : this.translations;
    key.split('.').forEach((String key) {
      value = value[key];
    });

    return value != null ? value.toString() : (english ? defaultValue : get(key, english: true, defaultValue: defaultValue));
  }

  bool isRTL() {
    return this.translations!['config']['direction'].toString().toUpperCase() == 'RTL';
  }

  TextDirection getTextDirection() {
    return isRTL() ? TextDirection.rtl : TextDirection.ltr;
  }
}