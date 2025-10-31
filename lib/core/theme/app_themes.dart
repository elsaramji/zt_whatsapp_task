import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static final _lightColorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.light,
    surface: AppColors.lightBackground,
    onSurface: AppColors.lightText,
    primary: AppColors.primary,
    onPrimary: Colors.white,
    secondary: AppColors.primary,
    onSecondary: Colors.white,
    error: Colors.red.shade700,
    onError: Colors.white,
  );

  static final _darkColorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.dark,
    surface: AppColors.darkBackground,
    onSurface: AppColors.darkText,
    primary: AppColors.primary,
    onPrimary: Colors.white,
    secondary: AppColors.primary,
    onSecondary: Colors.white,
    error: Colors.red.shade400,
    onError: Colors.black,
  );

  static final _baseTextTheme = GoogleFonts.robotoTextTheme();

  static final TextTheme _customTextTheme = _baseTextTheme.copyWith(
    titleLarge: _baseTextTheme.titleLarge?.copyWith(
      fontSize: 28.sp,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: _baseTextTheme.headlineSmall?.copyWith(
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: _baseTextTheme.bodyLarge?.copyWith(
      fontSize: 16.sp,
    ),
    bodyMedium: _baseTextTheme.bodyMedium?.copyWith(
      fontSize: 14.sp,
    ),
    labelLarge: _baseTextTheme.labelLarge?.copyWith(
      fontSize: 16.sp,
      fontWeight: FontWeight.bold,
    ),
    labelMedium: _baseTextTheme.labelMedium?.copyWith(
      fontSize: 12.sp,
      color: AppColors.grey,
    ),
  );

  // --- Light Theme ---
  static final ThemeData lightTheme = ThemeData(
    colorScheme: _lightColorScheme,
    scaffoldBackgroundColor: _lightColorScheme.surface,
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    
    textTheme: _customTextTheme.apply(
      bodyColor: _lightColorScheme.onBackground,
      displayColor: _lightColorScheme.onBackground,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: _lightColorScheme.surface,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColors.lightIcon),
      titleTextStyle: _customTextTheme.headlineSmall?.copyWith(
        color: _lightColorScheme.onSurface,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _lightColorScheme.primary,
        foregroundColor: _lightColorScheme.onPrimary,
        textStyle: _customTextTheme.labelLarge,
      ),
    ),

    iconTheme: const IconThemeData(color: AppColors.lightIcon),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _lightColorScheme.primary,
      foregroundColor: _lightColorScheme.onPrimary,
    ),

    tabBarTheme: TabBarThemeData(
      labelColor: AppColors.primary,
      unselectedLabelColor: AppColors.lightIcon,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: AppColors.primary, width: 2.w),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      hintStyle: _customTextTheme.bodyLarge?.copyWith(color: AppColors.grey),
      contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary, width: 2.w),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: _lightColorScheme.error),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: _lightColorScheme.error, width: 2.w),
      ),
    ),
  );

  // --- Dark Theme ---
  static final ThemeData darkTheme = ThemeData(
    colorScheme: _darkColorScheme,
    scaffoldBackgroundColor: _darkColorScheme.surface,
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    
    textTheme: _customTextTheme.apply(
      bodyColor: _darkColorScheme.onBackground,
      displayColor: _darkColorScheme.onBackground,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: _darkColorScheme.surface,
      elevation: 0,
      iconTheme: const IconThemeData(color: AppColors.darkIcon),
      titleTextStyle: _customTextTheme.headlineSmall?.copyWith(
        color: _darkColorScheme.onSurface,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _darkColorScheme.primary,
        foregroundColor: _darkColorScheme.onPrimary,
        textStyle: _customTextTheme.labelLarge,
      ),
    ),

    iconTheme: const IconThemeData(color: AppColors.darkIcon),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _darkColorScheme.primary,
      foregroundColor: _darkColorScheme.onPrimary,
    ),

    tabBarTheme: TabBarThemeData(
      labelColor: AppColors.primary,
      unselectedLabelColor: AppColors.darkIcon,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: AppColors.primary, width: 2.w),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      hintStyle: _customTextTheme.bodyLarge?.copyWith(color: AppColors.grey),
      contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary, width: 2.w),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: _darkColorScheme.error),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: _darkColorScheme.error, width: 2.w),
      ),
    ),
  );
}

