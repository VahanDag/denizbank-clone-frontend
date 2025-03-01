import 'package:denizbank_clone/core/constants/enums.dart';
import 'package:flutter/material.dart';

final class ActionsModel {
  final ActionsEnum? actionsEnum;
  final String actionsName;
  final Widget? icon;
  final void Function()? onTap;
  final Widget? routeTo;
  ActionsModel({
    this.actionsEnum,
    required this.actionsName,
    this.icon,
    this.onTap,
    this.routeTo,
  });
}
