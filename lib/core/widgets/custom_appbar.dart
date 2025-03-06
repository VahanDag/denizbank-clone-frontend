import 'package:denizbank_clone/core/constants/app_colors.dart';
import 'package:denizbank_clone/cubit/routers/routers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.height, this.leading, this.title, this.actions, this.bottom});

  final Widget? leading;
  final Widget? title;
  final Widget? bottom;
  final List<Widget>? actions;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.mainBlue,
      leading: leading ?? _defaultBack(context),
      title: title,
      actions: actions,
      centerTitle: true,
      bottom:
          PreferredSize(preferredSize: Size.fromHeight(height ?? kToolbarHeight), child: bottom ?? const SizedBox.shrink()),
    );
  }

  IconButton _defaultBack(BuildContext context) {
    return IconButton(
        onPressed: () {
          context.read<RoutersCubit>().pageToInitial();
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);
}

Text appBarTitle(String title, {double fontSize = 18}) {
  return Text(
    title.toUpperCase(),
    style: TextStyle(fontSize: fontSize, color: Colors.white, fontWeight: FontWeight.bold),
  );
}
