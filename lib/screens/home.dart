import 'package:denizbank_clone/core/constants/app_colors.dart';
import 'package:denizbank_clone/core/constants/app_strings.dart';
import 'package:denizbank_clone/core/constants/enums.dart';
import 'package:denizbank_clone/core/constants/extensions.dart';
import 'package:denizbank_clone/core/constants/paddings_borders.dart';
import 'package:denizbank_clone/cubit/cards/cards_cubit.dart';
import 'package:denizbank_clone/cubit/transaction/transaction_cubit.dart';
import 'package:denizbank_clone/cubit/user/user_cubit.dart';
import 'package:denizbank_clone/models/transaction_model.dart';
import 'package:denizbank_clone/models/widget_models.dart';
import 'package:denizbank_clone/screens/accounts/select_bank_acounts.dart';
import 'package:denizbank_clone/screens/auth/login/login_screen.dart';
import 'package:denizbank_clone/screens/transactions/send_money_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        return Scaffold(
          body: BlocBuilder<CardsCubit, CardsState>(
            builder: (context, cardState) {
              return HomeAndLoginTopArea(
                isAuthenticated: true,
                otherWidgets: const [],
                height: 0.2,
                tabWidth: 1,
                tabs: [_tabTexts(AppStrings.accounts), _tabTexts(AppStrings.cards), _tabTexts(AppStrings.financialSummary)],
                tabChildren: [
                  // Tab 0: Hesaplar - Banka kartı bilgileri
                  Accounts(tabIndex: 0, tabController: _tabController),
                  // Tab 1: Kartlar - Kredi kartı bilgileri
                  Accounts(tabIndex: 1, tabController: _tabController),
                  // Tab 2: Finansal Özet
                  Accounts(tabIndex: 2, tabController: _tabController),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Text _tabTexts(String text) => Text(
        text.toUpperCase(),
        maxLines: 1,
      );
}

class Accounts extends StatefulWidget {
  final int tabIndex;
  final TabController tabController;

  const Accounts({
    super.key,
    required this.tabIndex,
    required this.tabController,
  });

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  bool _isVisible = true;
  late List<ActionsModel> _debitCardActions;
  late List<ActionsModel> _creditCardActions;

  void _changeVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  void initState() {
    super.initState();

    // Banka kartı için işlemler
    _debitCardActions = [
      ActionsModel(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SendMoneyScreen()),
            );
          },
          actionsName: AppStrings.sendMoney2line,
          actionsEnum: ActionsEnum.sendMoney,
          icon: Icon(
            MdiIcons.currencyTry,
            color: Colors.white,
          )),
      ActionsModel(
          actionsName: AppStrings.payBill2Line,
          actionsEnum: ActionsEnum.payBill,
          icon: Icon(color: Colors.white, MdiIcons.receiptTextOutline)),
      ActionsModel(
          actionsName: AppStrings.qrActions2line,
          actionsEnum: ActionsEnum.qrActions,
          icon: Icon(color: Colors.white, MdiIcons.qrcode)),
      ActionsModel(
          actionsName: AppStrings.publishIban2line,
          actionsEnum: ActionsEnum.publishIBAN,
          icon: const Icon(color: Colors.white, Icons.file_upload_outlined)),
    ];

    // Kredi kartı için işlemler
    _creditCardActions = [
      ActionsModel(
          actionsName: "Kart\nDetay",
          actionsEnum: ActionsEnum.cardDetail,
          icon: Icon(color: Colors.white, MdiIcons.creditCardOutline)),
      ActionsModel(
          actionsName: "Borç\nÖde", actionsEnum: ActionsEnum.payDebt, icon: Icon(color: Colors.white, MdiIcons.cashCheck)),
      ActionsModel(
          actionsName: "Nakit\nAvans",
          actionsEnum: ActionsEnum.cashAdvance,
          icon: Icon(color: Colors.white, MdiIcons.cashFast)),
      ActionsModel(
          actionsName: "Limit\nGüncelle",
          actionsEnum: ActionsEnum.updateLimits,
          icon: Icon(color: Colors.white, MdiIcons.creditCardSettings)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserCubit>().state.user;
    var cardsCubit = context.watch<CardsCubit>();

    // Aktif tab kredi kartını mı (Cards tab) yoksa banka kartını mı (Accounts tab) göstermeli?
    bool isShowingCreditCard = widget.tabIndex == 1; // Tab index 1 = Kartlar tab'ı

    final selectedCard = isShowingCreditCard ? cardsCubit.selectedCreditCard : cardsCubit.selectedDebitCard;

    final actions = isShowingCreditCard ? _creditCardActions : _debitCardActions;

    return Column(
      children: [
        Container(
          height: context.deviceHeight * 0.22,
          width: double.infinity,
          color: const Color(0xff367cde),
          child: Column(
            children: [
              Container(
                margin: PaddingConstant.paddingHorizontalHigh.copyWith(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade300.withOpacity(0.6),
                  borderRadius: BorderRadiusConstant.borderRadius,
                ),
                child: ListTile(
                  contentPadding: PaddingConstant.paddingHorizontalLow.copyWith(left: 15),
                  title: Text(
                    selectedCard?.cardType.cardName ?? "Kart seçilmedi",
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    selectedCard != null
                        ? "${selectedCard.cardNumber.substring(selectedCard.cardNumber.length - 8)} / İstanbul"
                        : "",
                    style: const TextStyle(color: Colors.white),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SelectBankAcounts(selectedCard: selectedCard),
                                ));
                          },
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.white,
                          )),
                      VerticalDivider(
                        color: Colors.blue.shade300,
                      ),
                      IconButton(
                        onPressed: _changeVisibility,
                        icon: Icon(
                          _isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                isShowingCreditCard ? "Kullanılabilir Limit" : AppStrings.availableBalance,
                style: TextStyle(color: Colors.grey.shade300),
              ),
              Padding(
                padding: PaddingConstant.paddingOnlyTop,
                child: Text(
                  _isVisible ? "${isShowingCreditCard ? selectedCard?.balanceLimit : selectedCard?.balance} TL" : "***,**",
                  style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                collapsedHeight: 120,
                primary: false,
                floating: true,
                backgroundColor: AppColors.mainBlue,
                flexibleSpace: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    actions.length,
                    (index) => GestureDetector(
                      onTap: actions[index].onTap,
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            alignment: Alignment.center,
                            margin: PaddingConstant.paddingOnlyBottomLow,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade300.withOpacity(0.6),
                              borderRadius: BorderRadiusConstant.borderRadius,
                            ),
                            child: actions[index].icon,
                          ),
                          Text(
                            actions[index].actionsName,
                            textAlign: TextAlign.center,
                            style: context.textTheme.titleSmall?.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: PaddingConstant.paddingOnlyTopHigh,
                sliver: _isVisible
                    ? BlocBuilder<TransactionCubit, TransactionState>(
                        builder: (context, state) {
                          final isShowingCreditCard = widget.tabIndex == 1;
                          if (state is TransactionLoading) {
                            return const SliverFillRemaining(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else if (state is TransactionLoaded) {
                            List<TransactionModel>? transactions = state.transactions ?? [];
                            transactions.sort((a, b) => b.date!.compareTo(a.date ?? DateTime.now()));
                            return SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  final transaction = transactions[index];
                                  return ListTile(
                                    minVerticalPadding: 20,
                                    shape: const Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
                                    title: Text(isShowingCreditCard ? "Kredi Kartı Ödemesi" : "Hesap Hareketi"),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(isShowingCreditCard ? "Market alışverişi" : "Hesap transferi"),
                                        Text(transaction.date?.toFormattedDate ?? ""),
                                      ],
                                    ),
                                    trailing: Text(
                                      "${transaction.fromName == user?.name ? '-' : '+'} ${transaction.amount} TL",
                                      style: context.textTheme.titleMedium
                                          ?.copyWith(color: transaction.fromName == user?.name ? Colors.red : Colors.green),
                                    ),
                                  );
                                },
                                childCount: transactions.length ?? 0,
                              ),
                            );
                          } else {
                            return const SliverFillRemaining(
                                child: Center(child: Text("Hesap geçmişi çekilirken bir hata oluştu")));
                          }
                        },
                      )
                    : SliverFillRemaining(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.lock_outlined,
                              size: 75,
                            ),
                            Container(
                              padding: PaddingConstant.paddingAllHigh,
                              width: context.deviceWidth * 0.75,
                              child: Text(
                                  textAlign: TextAlign.center,
                                  style: context.textTheme.titleSmall,
                                  "Hesap geçmişinizi görüntüleyebilmek için görünürlülüğü aktif edin."),
                            )
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
