import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppShadows {
  AppShadows._();

  static const BoxShadow elevationZero = BoxShadow(
    color: Colors.transparent,
    blurRadius: 0,
    offset: Offset(0, 0),
  );

  static const BoxShadow elevationOne = BoxShadow(
    color: AppColors.shadowLight,
    blurRadius: 2,
    offset: Offset(0, 1),
  );

  static const List<BoxShadow> elevationTwo = [
    BoxShadow(
      color: AppColors.shadowLight,
      blurRadius: 3,
      offset: Offset(0, 1),
    ),
    BoxShadow(
      color: AppColors.shadowLight,
      blurRadius: 2,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> elevationThree = [
    BoxShadow(
      color: AppColors.shadow,
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];

  static const List<BoxShadow> elevationFour = [
    BoxShadow(
      color: AppColors.shadow,
      blurRadius: 12,
      offset: Offset(0, 6),
    ),
  ];

  static const List<BoxShadow> elevationFive = [
    BoxShadow(
      color: AppColors.shadowDark,
      blurRadius: 16,
      offset: Offset(0, 8),
    ),
  ];

  static const List<BoxShadow> cardShadow = [
    BoxShadow(
      color: AppColors.shadow,
      blurRadius: 8,
      offset: Offset(0, 2),
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> bottomSheetShadow = [
    BoxShadow(
      color: AppColors.shadowDark,
      blurRadius: 20,
      offset: Offset(0, -4),
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> appBarShadow = [
    BoxShadow(
      color: AppColors.shadow,
      blurRadius: 4,
      offset: Offset(0, 2),
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> buttonShadow = [
    BoxShadow(
      color: AppColors.shadow,
      blurRadius: 4,
      offset: Offset(0, 2),
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> floatingButtonShadow = [
    BoxShadow(
      color: AppColors.shadowDark,
      blurRadius: 12,
      offset: Offset(0, 4),
      spreadRadius: 0,
    ),
  ];
}