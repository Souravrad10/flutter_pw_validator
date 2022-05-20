import 'dart:ui';

/// MyColors hold constant colors used across the package
class MyColors {
  MyColors._();

  static const Color primary = Color(0xFF2F7BD6);
  static const Color secondary = Color(0xFF2CACDA);
  static const Color black = Color(0xFF000000);
  static const Color pink = Color(0xFFE13986);
  static const Color dark = Color(0xFF1F1F1F);
  static const Color green = Color(0xFF63D065);
  static const Color grey = Color(0xFFBFBFC8);
  static const Color white = Color(0xFFffffff);
  static const Color yellow = Color(0xFFFFB95A);
  static const Color red = Color(0xFFFF0000);
  static const Color primaryBlue = Color(0xFF3686DB);
  static const Color error = Color(0xFFFD2D55);
  static const Color passwordError = Color(0xFFE04336);
  static const Color passwordValid = Color(0xFF03A900);
  static const Color borderColor = Color(0xFFD6D6DC);
  static const Color shadow = Color(0xFF063B37);

  static const Map<int, Color> greyMap = {
    50: Color(0xFFE9E9EE),
    75: Color(0xFFD2D2D7),
    80: Color(0xffF2F2F2),
    100: Color(0xFFD1D1D6),
    150: Color(0xFFE4E7EC),
    200: Color(0xFFF8F8F9),
    500: Color(0xFF747474),
  };

  static const Map<int, Color> pinkMap = {
    200: Color(0xFFE51147),
    300: Color(0xFFD13962),
    400: Color(0xFFEF476F)
  };

  static const Map<int, Color> greenMap = {
    200: Color(0xFF56C758),
  };
}
