import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';

abstract class AppTheme {
  static ThemeData lightThemeData(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      primaryColor: const Color(0xFF0C54BE),
      scaffoldBackgroundColor: const Color(0xffF5F9FD),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0C54BE),
        primary: const Color(0xFF0C54BE),
        surface: Colors.white,
      ),
      textTheme: Theme.of(context).textTheme.apply(
            bodyColor: const Color(0xff303F60),
            displayColor: const Color(0xff303F60),
          ),
      extensions: const [
        AppColors(
          onSurface2: Color(0xffCED3DC),
        ),
      ],
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        isDense: true,
        isCollapsed: true,
        alignLabelWithHint: true,
        fillColor: Colors.white,
        errorBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        prefixIconColor: const Color(0xFF0C54BE),
        contentPadding: const EdgeInsets.all(Sizes.p12),
        hintStyle: const TextStyle(fontSize: 14, color: Color(0xff303F60)).regular,
        labelStyle: const TextStyle(fontSize: 14, color: Color(0xff303F60)).regular,
      ),
      appBarTheme: AppBarTheme(
        titleTextStyle: const TextStyle(fontSize: 20, color: Colors.white).bold,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          fixedSize: const Size(240, 52),
          textStyle: const TextStyle(fontSize: 16, color: Colors.white).bold,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Sizes.p12)),
        ),
      ),
    );
  }
}

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.onSurface2,
  });

  final Color? onSurface2;

  @override
  AppColors copyWith({
    Color? green,
    Color? onSurface2,
  }) {
    return AppColors(
      onSurface2: onSurface2 ?? this.onSurface2,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      onSurface2: Color.lerp(onSurface2, other.onSurface2, t),
    );
  }

  @override
  String toString() => 'AppColors(onSurface2: $onSurface2)';
}

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  ScaffoldMessengerState? errorSnackBar([String? text]) =>
      text == null || text.isEmpty ? null : ScaffoldMessenger.of(this)
        ?..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            showCloseIcon: true,
            backgroundColor: colorScheme.error,
            behavior: SnackBarBehavior.floating,
            content: Text(text!),
          ),
        );

  ScaffoldMessengerState successSnackBar([
    String? text,
  ]) =>
      ScaffoldMessenger.of(this)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            showCloseIcon: true,
            backgroundColor: Colors.green,
            content: Text(text ?? "Success"),
            behavior: SnackBarBehavior.floating,
          ),
        );
}

extension TextStyleX on TextStyle {
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
}
