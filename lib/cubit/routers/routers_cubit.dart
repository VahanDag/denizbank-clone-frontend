import 'package:denizbank_clone/core/constants/app_strings.dart';
import 'package:denizbank_clone/screens/applications/applications.dart';
import 'package:denizbank_clone/screens/fast/fast_transactions.dart';
import 'package:denizbank_clone/screens/home.dart';
import 'package:denizbank_clone/screens/auth/login/login_screen.dart';
import 'package:denizbank_clone/screens/menu/menu.dart';
import 'package:denizbank_clone/screens/transactions/send_money_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'routers_state.dart';

class RoutersCubit extends Cubit<RoutersState> {
  RoutersCubit(this.isAuth) : super(RoutersInitial()) {
    _initializePages();
  }

  void updateAuthStatus(bool newAuthStatus) {
    if (isAuth != newAuthStatus) {
      isAuth = newAuthStatus;
      _initializePages();
      pageToInitial();
    }
  }

  void _initializePages() {
    pages = [
      isAuth ? const HomeScreen() : const FastTransactionsScreen(),
      const Applications(),
      MenuScreen(),
      isAuth ? const SendMoneyScreen() : const Text(AppStrings.nonOffice),
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
    selectedItem = isAuth ? titles.first : AppStrings.login;
    selectedItemIndex = isAuth ? 0 : -1;
    emit(RoutersInitial());
  }

  void changeItem(int index) {
    if (index >= 0 && index < titles.length) {
      selectedItem = titles[index];
      selectedItemIndex = index;
      emit(OtherPage());
    }
  }

  bool isAuth;
  String selectedItem = '';
  int selectedItemIndex = 0;

  late List<Widget> pages;
  late List<String> titles;
}
