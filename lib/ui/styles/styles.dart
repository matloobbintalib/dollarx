import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class Styles {
  Styles._();

  static LinearGradient linearGradient = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.primaryGreen, AppColors.primaryRed],
  );

  static const List<Color> blueButtonGradientColors = [
    Color(0xff3E4292),
    Color(0xff000336),
  ];
  static const List<Color> blackButtonGradientColors = [
    Color(0xff5C5C5C),
    Color(0xff0F0F0F),
  ];
}
