import 'package:flutter/rendering.dart';
import '../constant/my_colors.dart';

class MyDecorations {
  MyDecorations._();
  static BoxDecoration mainGradient = const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(18)),
      gradient: LinearGradient(
        colors: GradientColors.bottomNav,
      ));
}
