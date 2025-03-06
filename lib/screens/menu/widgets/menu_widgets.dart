import 'package:denizbank_clone/core/constants/extensions.dart';
import 'package:denizbank_clone/core/constants/paddings_borders.dart';
import 'package:denizbank_clone/models/widget_models.dart';
import 'package:flutter/material.dart';

GestureDetector actionsCard(BuildContext context, ActionsModel action,
    {double? height, EdgeInsetsGeometry? margin, void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      elevation: 5,
      margin: margin ?? PaddingConstant.paddingHorizontal,
      child: Container(
          alignment: Alignment.center,
          height: height,
          padding: PaddingConstant.paddingHorizontalMedium,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: PaddingConstant.paddingOnlyRight,
                child: action.icon,
              ),
              Text(
                maxLines: 2,
                action.actionsName,
                style: context.textTheme.titleSmall,
              ),
            ],
          )),
    ),
  );
}
