import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  double get deviceWidth => MediaQuery.of(this).size.width;
  double get deviceHeight => MediaQuery.of(this).size.height;
  TextTheme get textTheme => Theme.of(this).textTheme;
}
