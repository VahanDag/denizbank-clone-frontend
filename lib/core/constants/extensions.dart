import 'package:denizbank_clone/core/constants/enums.dart';
import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  double get deviceWidth => MediaQuery.of(this).size.width;
  double get deviceHeight => MediaQuery.of(this).size.height;
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension WidgetMargin on Widget {
  Padding margin(EdgeInsets margin) => Padding(padding: margin, child: this);
}

extension IconEnumExtension on IconEnum {
  String get iconName => "assets/images/icons/ic_$name.png";
}

extension StringExtension on String {
  String get toTitleCase => "${this[0].toUpperCase()}${substring(1)}";
  String get toLowerCase => this.toLowerCase();
  String get toUpperCase => this.toUpperCase();
  String get trimToText => trim();
  String get trimToTextLower => trim().toLowerCase();
  int get toInt => int.parse(this);
  double get toDouble => double.parse(this);
}
