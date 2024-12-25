import 'package:flutter/material.dart';

class AppTheme {
  static const black = Color(0xFF000000);
  static const sunburntCyclops = Color(0xFFFF4855);
  static const white = Color(0xFFFFFFFF);

  static final lightThemeData = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: AppTheme.sunburntCyclops,
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: const WidgetStatePropertyAll(AppTheme.white),
      fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return AppTheme.sunburntCyclops;
        }
        return Colors.transparent;
      }),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
      side: WidgetStateBorderSide.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return BorderSide.none;
          }
          return BorderSide(color: AppTheme.black.withOpacity(.2), width: 2);
        },
      ),
    ),
    useMaterial3: true,
  );
}
