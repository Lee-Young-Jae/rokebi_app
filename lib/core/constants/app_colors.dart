import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF4087FF);
  static const Color primaryDark = Color(0xFF4455F5);
  static const Color primaryLight = Color(0xFF6BA0FF);

  static const Color secondary = Color(0xFF15BA88);
  static const Color secondaryLight = Color(0xFF4DC9A0);
  static const Color secondaryDark = Color(0xFF0D9B6F);

  static const Color success = Color(0xFF15BA88);
  static const Color warning = Color(0xFFFFA726);
  static const Color error = Color(0xFFEE4423);
  static const Color info = Color(0xFF4087FF);

  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFFAFAFA);

  static const Color textPrimary = Color(0xFF2C2C2C);
  static const Color textSecondary = Color(0xFF777777);
  static const Color textHint = Color(0xFF9E9E9E);
  static const Color textDisabled = Color(0xFFBDBDBD);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  static const Color divider = Color(0xFFE0E0E0);
  static const Color border = Color(0xFFBDBDBD);
  static const Color borderLight = Color(0xFFE0E0E0);

  static const Color shadow = Color(0x1A000000);
  static const Color shadowLight = Color(0x0A000000);
  static const Color shadowDark = Color(0x33000000);

  static const Color productBadgeRed = Color(0xFFEE4423);
  static const Color productBadgeGreen = Color(0xFF15BA88);
  static const Color productBadgeBlack = Color(0xFF2C2C2C);

  static const Color tabBarIndicator = Color(0xFF333333); // #333

  static const Color planWarningBox = Color(0xFF3D3D3D); //#3D3D3D

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryDark, primary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
