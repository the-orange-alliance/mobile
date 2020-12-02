import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

import './internationalization/localizations-delegate.dart';
import './ui/colors.dart' as TOAColors;
import './ui/views/events/events-list-page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => ThemeData(
        primarySwatch: TOAColors.Colors().toaColors,
        accentColor: brightness == Brightness.dark
          ? TOAColors.Colors().toaColors.shade600
          : null,
        fontFamily: 'GoogleSans',
        cardTheme: CardTheme(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6))
          )
        ),
        brightness: brightness
      ),
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          title: 'The Orange Alliance',
          theme: theme,
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
          localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) {
//            return supportedLocales.elementAt(1); // Debug Hebrew
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
      }
    );
  }
}
