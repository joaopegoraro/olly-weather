import 'package:flutter/widgets.dart';

final class OllyWeatherSpacing {
  OllyWeatherSpacing._();

  // Radius

  /// 4px
  static const double tinyRadius = 4.0;

  /// 16px
  static const double mediumRadius = 16.0;

  /// 30px
  static const double largeRadius = 30.0;

  // Padding

  /// 8px
  static const double tinyPadding = 8.0;

  /// 10px
  static const double smallPadding = 10.0;

  /// 12px
  static const double regularPadding = 12.0;

  /// 16px
  static const double mediumPadding = 16.0;

  /// 20px
  static const double bigPadding = 20.0;

  /// 32px
  static const double largePadding = 32.0;

  // Horizontal Spacing

  /// 10px
  static const Widget horizontalSpaceSmall = SizedBox(width: 10.0);

  /// 18px
  static const Widget horizontalSpaceRegular = SizedBox(width: 18.0);

  // Vertical Spacing

  /// 10px
  static const Widget verticalSpaceSmall = SizedBox(height: 10.0);

  /// 18px
  static const Widget verticalSpaceRegular = SizedBox(height: 18.0);

  /// 40px
  static const Widget verticalSpaceLarge = SizedBox(height: 40.0);
}
