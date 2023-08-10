import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

import './internationalization/localizations-delegate.dart';
import './ui/colors.dart' as TOAColors;
import './ui/views/events/events-list-page.dart';

Future<void> main() async {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
  };
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  ThemeData _theme(Brightness brightness) => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: TOAColors.Colors.toaColors,
          primary: TOAColors.Colors.toaColors,
          secondary: brightness == Brightness.dark
              ? TOAColors.Colors.toaColors.shade600
              : null,
          brightness: brightness,
        ),
        fontFamily: 'GoogleSans',
        cardTheme: CardTheme(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            padding: EdgeInsets.all(12),
            backgroundColor: TOAColors.Colors.toaColors,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return EasyDynamicThemeWidget(
      initialThemeMode: ThemeMode.system,
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'The Orange Alliance',
            theme: _theme(Brightness.light),
            darkTheme: _theme(Brightness.dark),
            themeMode: EasyDynamicTheme.of(context).themeMode,
            home: EventsListPage(),
            supportedLocales: [
              const Locale('en', 'US'), // English, must be first
              const Locale('he', 'IL'), // Hebrew
              const Locale('es', 'MX'), // Hebrew
            ],
            localizationsDelegates: [
              const TOALocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            localeResolutionCallback: (
              Locale? locale,
              Iterable<Locale> supportedLocales,
            ) {
              // return supportedLocales.elementAt(1); // Debug Hebrew
              if (locale != null) {
                for (Locale supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale.languageCode ||
                      supportedLocale.countryCode == locale.countryCode) {
                    return supportedLocale;
                  }
                }
              }
              return supportedLocales.first; // Default: English
            },
          );
        },
      ),
    );
  }
}
