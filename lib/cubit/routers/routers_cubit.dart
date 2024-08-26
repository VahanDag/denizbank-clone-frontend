import 'package:denizbank_clone/core/constants/app_strings.dart';
import 'package:denizbank_clone/screens/applications/applications.dart';
import 'package:denizbank_clone/screens/fast/fast_transactions.dart';
import 'package:denizbank_clone/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'routers_state.dart';

class RoutersCubit extends Cubit<RoutersState> {
  RoutersCubit(this.isAuth) : super(RoutersInitial()) {
    pages = [
      isAuth ? const Text(AppStrings.home) : const FastTransactionsScreen(),
      const Applications(),
      const Text(AppStrings.menu),
      isAuth ? const Text(AppStrings.sendMoney) : const Text(AppStrings.nonOffice),
      isAuth ? const Text(AppStrings.defray) : const Text(AppStrings.campaign),
      if (!isAuth) const LoginScreen()
    ];

    titles = [
      isAuth ? AppStrings.home : AppStrings.fast,
      AppStrings.applications,
      AppStrings.menu,
      isAuth ? AppStrings.sendMoney : AppStrings.nonOffice,
      isAuth ? AppStrings.defray : AppStrings.campaign
    ];

    selectedItem = isAuth ? titles.first : AppStrings.login;
    selectedItemIndex = isAuth ? 0 : -1;
  }

  void pageToOther() {
    emit(OtherPage());
  }

  void pageToInitial() {
    emit(RoutersInitial());
  }

  void changeItem(int index) {
    print(index);
    selectedItem = titles[index];
    selectedItemIndex = index;
    emit(OtherPage());
  }

  late bool isAuth;
  late String selectedItem;
  late int selectedItemIndex;

  late final List<Widget> pages;
  late final List<String> titles;
}
