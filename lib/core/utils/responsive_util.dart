import 'package:flutter/material.dart';

class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 768 &&
      MediaQuery.of(context).size.width < 1100;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  static double sectionPadding(BuildContext context) =>
      isMobile(context) ? 24.0 : isTablet(context) ? 48.0 : 80.0;

  static double contentMaxWidth(BuildContext context) =>
      isMobile(context) ? double.infinity : isTablet(context) ? 720.0 : 1200.0;
}
