// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:denizbank_clone/core/constants/paddings_borders.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    this.margin,
    required this.controller,
    required this.tabs,
  });
  final EdgeInsetsGeometry? margin;
  final TabController controller;
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? PaddingConstant.paddingAllHigh,
      decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadiusConstant.borderRadiusMedium),
      child: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          labelPadding: PaddingConstant.paddingAll,
          labelColor: Colors.white,
          dividerColor: Colors.transparent,
          unselectedLabelColor: Colors.grey.shade700,
          indicator: BoxDecoration(color: Colors.blue, borderRadius: BorderRadiusConstant.borderRadius),
          controller: controller,
          tabs: tabs),
    );
  }
}
