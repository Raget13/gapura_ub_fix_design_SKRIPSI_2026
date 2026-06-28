import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/app_theme.dart';
import 'screens/splash_screen.dart';

/// Notifier global untuk dark mode — dipakai di seluruh halaman.
ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

/// Notifier global untuk bahasa — 'id' = Indonesia, 'en' = English.
ValueNotifier<Locale> localeNotifier = ValueNotifier(const Locale('id'));

void main() {
  runApp(const GapuraUBApp());
}

class GapuraUBApp extends StatelessWidget {
  const GapuraUBApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, _) {
        return ValueListenableBuilder<Locale>(
          valueListenable: localeNotifier,
          builder: (context, currentLocale, _) {
            return MaterialApp(
              title: 'Gapura UB',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: currentMode,
              locale: currentLocale,
              supportedLocales: const [Locale('id'), Locale('en')],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              home: const SplashScreen(),
            );
          },
        );
      },
    );
  }
}
