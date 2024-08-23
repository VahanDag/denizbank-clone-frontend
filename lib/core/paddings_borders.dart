import 'package:flutter/material.dart';

mixin PaddingConstant {
  // Padding all
  static const EdgeInsets paddingAllLow = EdgeInsets.all(5);
  static const EdgeInsets paddingAll = EdgeInsets.all(10);
  static const EdgeInsets paddingAllMedium = EdgeInsets.all(15);
  static const EdgeInsets paddingAllHigh = EdgeInsets.all(20);

  // Padding Horizontal
  static const EdgeInsets paddingHorizontalLow = EdgeInsets.symmetric(horizontal: 5);
  static const EdgeInsets paddingHorizontal = EdgeInsets.symmetric(horizontal: 10);
  static const EdgeInsets paddingHorizontalMedium = EdgeInsets.symmetric(horizontal: 15);
  static const EdgeInsets paddingHorizontalHigh = EdgeInsets.symmetric(horizontal: 20);

  // Padding Vertical
  static const EdgeInsets paddingVerticalLow = EdgeInsets.symmetric(vertical: 5);
  static const EdgeInsets paddingVertical = EdgeInsets.symmetric(vertical: 10);
  static const EdgeInsets paddingVerticalMedium = EdgeInsets.symmetric(vertical: 15);
  static const EdgeInsets paddingVerticalHigh = EdgeInsets.symmetric(vertical: 20);

  // Padding only right
  static const EdgeInsets paddingOnlyRightLow = EdgeInsets.only(right: 5);
  static const EdgeInsets paddingOnlyRight = EdgeInsets.only(right: 10);
  static const EdgeInsets paddingOnlyRightMedium = EdgeInsets.only(right: 15);
  static const EdgeInsets paddingOnlyRightHigh = EdgeInsets.only(right: 20);

  // Padding only right
  static const EdgeInsets paddingOnlyLeftLow = EdgeInsets.only(left: 5);
  static const EdgeInsets paddingOnlyLeft = EdgeInsets.only(left: 10);
  static const EdgeInsets paddingOnlyLeftMedium = EdgeInsets.only(left: 15);
  static const EdgeInsets paddingOnlyLeftHigh = EdgeInsets.only(left: 20);

  // Padding only right
  static const EdgeInsets paddingOnlyBottomLow = EdgeInsets.only(bottom: 5);
  static const EdgeInsets paddingOnlyBottom = EdgeInsets.only(bottom: 10);
  static const EdgeInsets paddingOnlyBottomMedium = EdgeInsets.only(bottom: 15);
  static const EdgeInsets paddingOnlyBottomHigh = EdgeInsets.only(bottom: 20);

  // Padding only right
  static const EdgeInsets paddingOnlyTopLow = EdgeInsets.only(top: 5);
  static const EdgeInsets paddingOnlyTop = EdgeInsets.only(top: 10);
  static const EdgeInsets paddingOnlyTopMedium = EdgeInsets.only(top: 15);
  static const EdgeInsets paddingOnlyTopHigh = EdgeInsets.only(top: 20);
}

mixin BorderRadiusConstant {
  // Border Radius
  static final BorderRadius borderRadiusLow = BorderRadius.circular(5);
  static final BorderRadius borderRadius = BorderRadius.circular(10);
  static final BorderRadius borderRadiusMedium = BorderRadius.circular(15);
  static final BorderRadius borderRadiusHigh = BorderRadius.circular(20);

  static const BorderRadius borderRadiusSheet =
      BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30));
}
