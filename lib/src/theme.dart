
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final themeModeProvider = StateProvider<ThemeMode>((_) => ThemeMode.dark);
final brandProvider = StateProvider<BrandTheme>((_) => const BrandTheme());

class BrandTheme {
  final Color primary;
  final Color surfaceDark;
  final Color bgDark;
  final Color surfaceLight;
  final Color bgLight;
  final Color success;
  final Color warning;
  final Color danger;
  const BrandTheme({
    this.primary = const Color(0xFF8B0000),
    this.surfaceDark = const Color(0xFF0A0A0A),
    this.bgDark = const Color(0xFF000000),
    this.surfaceLight = const Color(0xFFF8F8F8),
    this.bgLight = const Color(0xFFFFFFFF),
    this.success = const Color(0xFF16A34A),
    this.warning = const Color(0xFFF59E0B),
    this.danger = const Color(0xFFDC2626),
  });
}

ThemeData buildTheme(WidgetRef ref, {required bool isDark}) {
  final b = ref.watch(brandProvider);
  final base = isDark ? ThemeData.dark(useMaterial3: true) : ThemeData.light(useMaterial3: true);
  final colorScheme = isDark
      ? ColorScheme.fromSeed(seedColor: b.primary, primary: b.primary, surface: b.surfaceDark, background: b.bgDark, brightness: Brightness.dark)
      : ColorScheme.fromSeed(seedColor: b.primary, primary: b.primary, surface: b.surfaceLight, background: b.bgLight, brightness: Brightness.light);
  return base.copyWith(
    colorScheme: colorScheme,
    textTheme: GoogleFonts.interTextTheme(base.textTheme.apply(
      bodyColor: isDark ? Colors.white : Colors.black,
      displayColor: isDark ? Colors.white : Colors.black,
    )),
    scaffoldBackgroundColor: colorScheme.background,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: isDark ? const Color(0xFF0E0E0E) : const Color(0xFFF2F2F2),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
