import 'package:flutter/material.dart';

class AppRadius {
  AppRadius._();

  static const double none = 0.0;
  static const double xs = 0.0;
  static const double sm = 0.0;
  static const double md = 0.0;
  static const double lg = 0.0;
  static const double xl = 0.0;
  static const double xxl = 0.0;
  static const double full = 999.0;

  static const BorderRadius borderRadiusNone = BorderRadius.zero;
  static const BorderRadius borderRadiusXS = BorderRadius.zero;
  static const BorderRadius borderRadiusSM = BorderRadius.zero;
  static const BorderRadius borderRadiusMD = BorderRadius.zero;
  static const BorderRadius borderRadiusLG = BorderRadius.zero;
  static const BorderRadius borderRadiusXL = BorderRadius.zero;
  static const BorderRadius borderRadiusXXL = BorderRadius.zero;
  static const BorderRadius borderRadiusFull = BorderRadius.all(Radius.circular(full));

  static const BorderRadius borderRadiusTop = BorderRadius.zero;

  static const BorderRadius borderRadiusBottom = BorderRadius.zero;

  static const BorderRadius borderRadiusLeft = BorderRadius.zero;

  static const BorderRadius borderRadiusRight = BorderRadius.zero;

  static const Radius radiusXS = Radius.zero;
  static const Radius radiusSM = Radius.zero;
  static const Radius radiusMD = Radius.zero;
  static const Radius radiusLG = Radius.zero;
  static const Radius radiusXL = Radius.zero;
  static const Radius radiusXXL = Radius.zero;
  static const Radius radiusFull = Radius.circular(full);

  static const RoundedRectangleBorder shapeXS = RoundedRectangleBorder(
    borderRadius: borderRadiusXS,
  );

  static const RoundedRectangleBorder shapeSM = RoundedRectangleBorder(
    borderRadius: borderRadiusSM,
  );

  static const RoundedRectangleBorder shapeMD = RoundedRectangleBorder(
    borderRadius: borderRadiusMD,
  );

  static const RoundedRectangleBorder shapeLG = RoundedRectangleBorder(
    borderRadius: borderRadiusLG,
  );

  static const RoundedRectangleBorder shapeXL = RoundedRectangleBorder(
    borderRadius: borderRadiusXL,
  );
}