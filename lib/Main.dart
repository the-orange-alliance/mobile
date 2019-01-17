import 'package:flutter/material.dart';
import 'package:toa_flutter/ui/Colors.dart' as TOAColors;
import 'package:toa_flutter/ui/views/events/EventsListPage.dart';
import 'package:toa_flutter/internationalization/LocalizationsDelegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // Root widget
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Orange Alliance',
      theme: ThemeData(
        primarySwatch: new TOAColors.Colors().toaColors,
        fontFamily: 'GoogleSans',
      ),
      home: EventsListPage(),
      supportedLocales: [
        const Locale('en', 'US'), // English, must be first
        const Locale('he', 'IL'), // Hebrew
      ],
      localizationsDelegates: [
        const TOALocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) {
//        return supportedLocales.elementAt(1); // Debug Hebrew
        if (locale != null) {
          for (Locale supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode || supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
        }
        return supportedLocales.first; // Default: English
      },
    );
  }
}