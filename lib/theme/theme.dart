import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTheme extends GetxController {
  RxBool isDarkMode = false.obs;
  final lightColorScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF186C32),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFA2F6AB),
    onPrimaryContainer: Color(0xFF002109),
    secondary: Color(0xFF516351),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFD4E8D1),
    onSecondaryContainer: Color(0xFF0F1F11),
    tertiary: Color(0xFF39656D),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFBDEAF3),
    onTertiaryContainer: Color(0xFF001F24),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFCFDF7),
    onBackground: Color(0xFF1A1C19),
    surface: Color(0xFFFCFDF7),
    onSurface: Color(0xFF1A1C19),
    surfaceVariant: Color(0xFFDDE5D9),
    onSurfaceVariant: Color(0xFF424941),
    outline: Color(0xFF727970),
    onInverseSurface: Color(0xFFF0F1EB),
    inverseSurface: Color(0xFF2E312D),
    inversePrimary: Color(0xFF87D991),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF186C32),
    outlineVariant: Color(0xFFC1C9BE),
    scrim: Color(0xFF000000),
  );

  final darkColorScheme = const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF87D991),
    onPrimary: Color(0xFF003914),
    primaryContainer: Color.fromARGB(255, 5, 43, 19),
    onPrimaryContainer: Color(0xFFA2F6AB),
    secondary: Color(0xFFB8CCB6),
    onSecondary: Color(0xFF243425),
    secondaryContainer: Color(0xFF3A4B3A),
    onSecondaryContainer: Color(0xFFD4E8D1),
    tertiary: Color(0xFFA1CED7),
    onTertiary: Color(0xFF00363D),
    tertiaryContainer: Color(0xFF1F4D54),
    onTertiaryContainer: Color(0xFFBDEAF3),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF1A1C19),
    onBackground: Color(0xFFE2E3DD),
    surface: Color(0xFF1A1C19),
    onSurface: Color(0xFFE2E3DD),
    surfaceVariant: Color(0xFF424941),
    onSurfaceVariant: Color(0xFFC1C9BE),
    outline: Color(0xFF8B9389),
    onInverseSurface: Color(0xFF1A1C19),
    inverseSurface: Color(0xFFE2E3DD),
    inversePrimary: Color(0xFF186C32),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF87D991),
    outlineVariant: Color(0xFF424941),
    scrim: Color(0xFF000000),
  );

  void changeTheme() {
    isDarkMode.value = !isDarkMode.value;
    print("chage mode $isDarkMode");
  }
}
