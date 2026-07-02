import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'Nimora';
  /// Root URL for every API call.
  static const String baseUrl = 'https://app-cd8d2a6c-932d-4b7f-95c9-26bfb1145c77.cleverapps.io';

  /// Connection timeout in milliseconds.
  static const int connectTimeoutMs = 30000;

  /// Receive timeout in milliseconds.
  static const int receiveTimeoutMs = 30000;

  // ── API Endpoints ─────────────────────────────────────────────────────────

  static const String signIn = '$baseUrl/api/auth/login';
  static const String register = '$baseUrl/api/auth/register';
  static const String forgotPassword = '$baseUrl/api/auth/forgot-password';
  static const String resetPassword = '$baseUrl/api/auth/reset-password';

  /// Different sizes used in the app
  static const double size2 = 2.0;

  /// Different Text Sizes
  static const double textSizes9 = 8.0;
  static const double textSizes10 = 10.0;
  static const double textSizes12 = 12.0;
  static const double textSizes13 = 13.0;
  static const double textSizes14 = 14.0;
  static const double textSizes16 = 16.0;
  static const double textSizes18 = 18.0;
  static const double textSizes20 = 20.0;

  /// Padding Values
  static const PaddingAmount paddings2 = 2.0;
  static const PaddingAmount paddings8 = 8.0;
  static const PaddingAmount paddings12 = 12.0;
  static const PaddingAmount paddings16 = 16.0;
  static const PaddingAmount paddings20 = 20.0;
  static const PaddingAmount paddings24 = 24.0;

  /// Spacing Values
  static const double spacing5 = 5.0;
  static const double spacing8 = 8.0;
  static const double spacing10 = 10.0;

  /// Border Radius
  static const double borderRadius8 = 8.0;

  /// Icon Sizes
  static const double iconSize20 = 20.0;

  /// Layout Flex Values
  static const int portraitFlex = 15;
  static const int landscapeFlex = 35;
  static const int landscapeLocationFlex = 50;

  /// Engagement Additional Widget Padding
  static const EdgeInsets engagementCardPadding = EdgeInsets.only(
    right: 24,
    top: 12,
    bottom: 12,
    left: 12,
  );
  static const EdgeInsets statusChipPadding = EdgeInsets.all(2.0);

  static RegExp removeFirstSpaceRegX = RegExp(r'^\s');
  static RegExp budgetRegex = RegExp(r'^0[1-9]\d{0,4}(\.\d{0,2})?$');
  static String epochTime = DateTime.now().microsecondsSinceEpoch.toString();
  static RegExp removeSplChRegX = RegExp(r'[`"~_<>!@#$%^,/?:;{|}&*+()=-]');
  static RegExp removeAlpRegX = RegExp(r'[a-zA-Z]');
  static const double borderWidth = 1.0;
  static const EdgeInsets appBarPadding1 = EdgeInsets.symmetric(horizontal: 16);
  static const double borderRadius = 12.0;

}

typedef PaddingAmount = double;

extension PaddingExt on PaddingAmount {
  EdgeInsets get vertical => EdgeInsets.symmetric(vertical: this);
  EdgeInsets get horizontal => EdgeInsets.symmetric(horizontal: this);
  EdgeInsets get all => EdgeInsets.all(this);
  EdgeInsets get left => EdgeInsets.only(left: this);
  EdgeInsets get right => EdgeInsets.only(right: this);
  EdgeInsets get top => EdgeInsets.only(top: this);
  EdgeInsets get bottom => EdgeInsets.only(bottom: this);
}
