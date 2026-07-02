import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF086D63);
  static const Color primaryLight = Color(0xFF5B93A3);
  static const Color primaryDark = Color(0xFFC44E1A);
  static const Color primarySurface = Color(0xFFFFF0EA);
  static const Color hourlyRate = Color(0xFF00A63E);
  static const Color appbarBackground = Color(0xFFE0E0E0);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF0A0A0A);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey300 = Color(0xFFD1D5DB);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey800 = Color(0xFF424242);
  static const Color skipText = Color(0xFF343434);

  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textHint = Color(0xFFADB5BD);

  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFAFAFA);

  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFE8622A), Color(0xFFC44E1A)],
  );

  static const LinearGradient imageOverlay = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0x40E8622A), Color(0xB0E8622A)],
  );
}

class NdisThemeStyle {
  NdisThemeStyle._();

  static TextStyle get displayLarge => GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    letterSpacing: -0.44,
  );

  static TextStyle get displayMedium => GoogleFonts.inter(
    fontSize: 26,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    letterSpacing: -0.44,
  );

  static TextStyle get headlineLarge => GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.30,
  );

  static TextStyle get headlineMedium => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.30,
  );

  static TextStyle get bodyLarge => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    letterSpacing: -0.15,
  );

  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    letterSpacing: -0.15,
  );

  static TextStyle get labelLarge => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
    letterSpacing: -0.15,
  );

  static TextStyle get splashBrand => GoogleFonts.inter(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: AppColors.white,
    letterSpacing: -0.44,
  );
}

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      onPrimary: AppColors.white,
      background: AppColors.background,
      surface: AppColors.surface,
    ),
    scaffoldBackgroundColor: AppColors.background,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        minimumSize: const Size(double.infinity, 54),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 0,
        textStyle: NdisThemeStyle.labelLarge,
      ),
    ),
    textTheme: GoogleFonts.interTextTheme(),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.grey600,
        textStyle: NdisThemeStyle.bodyMedium.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

class AppDimensions {
  AppDimensions._();

  static const double paddingXS = 4.0;
  static const double paddingS = 8.0;
  static const double paddingM = 16.0;
  static const double paddingL = 24.0;
  static const double paddingXL = 32.0;
  static const double paddingXXL = 48.0;

  static const double radiusS = 8.0;
  static const double radiusM = 14.0;
  static const double radiusL = 20.0;
  static const double radiusXL = 28.0;
  static const double radiusRound = 100.0;

  static const double imageHeightRatio = 0.52;
  static const double buttonHeight = 54.0;
}
