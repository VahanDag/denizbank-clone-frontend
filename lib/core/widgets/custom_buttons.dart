// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:denizbank_clone/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:denizbank_clone/core/constants/extensions.dart';
import 'package:denizbank_clone/core/constants/paddings_borders.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.width = 0.5,
    this.height = 45,
    required this.onPressed,
    this.buttonColor = AppColors.mainBlue,
    this.textColor = Colors.white,
    required this.text,
    this.margin,
    this.isOutline = false,
  });
  final double? width;
  final double? height;
  final void Function() onPressed;
  final Color? buttonColor;
  final Color? textColor;
  final String text;
  final EdgeInsetsGeometry? margin;
  final bool isOutline;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: margin,
        alignment: Alignment.center,
        width: context.deviceWidth * width!,
        height: height,
        decoration: BoxDecoration(
            border: Border.all(color: isOutline ? buttonColor! : Colors.transparent),
            color: isOutline ? textColor : buttonColor,
            borderRadius: BorderRadiusConstant.borderRadiusLow),
        child: Text(text.toUpperCase(),
            style: context.textTheme.titleMedium
                ?.copyWith(color: isOutline ? buttonColor : textColor, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
