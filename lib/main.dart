import 'package:flutter/material.dart';
import 'core/app_theme.dart';
import 'screens/splash_screen.dart';

/// Notifier global untuk dark mode — dipakai di seluruh halaman.
/// Diakses dari mana saja dengan: AppTheme.themeNotifier.value = ThemeMode.dark;
ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

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
        return MaterialApp(
          title: 'Gapura UB',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: currentMode,
          home: const SplashScreen(),
        );
      },
    );
  }
}
