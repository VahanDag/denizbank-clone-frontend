import 'package:denizbank_clone/core/constants/enums.dart';
import 'package:denizbank_clone/core/widgets/custom_loading.dart';
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

extension CampaignBannersEnumExtension on CampaignBanners {
  String get iconName => "assets/images/campaigns/campaign_$name.png";
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

extension DateTimeExtension on DateTime {
  String get toFormattedDate => "${day.toString().padLeft(2, '0')}.${month.toString().padLeft(2, '0')}.${year.toString()}";
}

extension FutureLoadingExtension<T> on Future<T> {
  Future<T> withLoading(BuildContext context) {
    return LoadingOverlay.during(context, this);
  }
}
