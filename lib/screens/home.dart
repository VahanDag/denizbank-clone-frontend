import 'package:denizbank_clone/core/constants/app_colors.dart';
import 'package:denizbank_clone/core/constants/app_strings.dart';
import 'package:denizbank_clone/core/constants/enums.dart';
import 'package:denizbank_clone/core/constants/extensions.dart';
import 'package:denizbank_clone/core/constants/paddings_borders.dart';
import 'package:denizbank_clone/cubit/user/user_cubit.dart';
import 'package:denizbank_clone/models/widget_models.dart';
import 'package:denizbank_clone/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Scaffold(
          body: HomeAndLoginTopArea(
            otherWidgets: const [],
            height: 0.2,
            tabWidth: 1,
            tabs: [_tabTexts(AppStrings.accounts), _tabTexts(AppStrings.cards), _tabTexts(AppStrings.financialSummary)],
            tabChildren: const [Accounts(), Accounts(), Accounts()],
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
  const Accounts({
    super.key,
  });

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  late final List<ActionsModel> _actions;
  bool _isVisible = true;
  void _changeVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  void initState() {
    _actions = [
      ActionsModel(
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = context.read<UserCubit>().state.user;

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
                  title: const Text(
                    "Vahan Dağ",
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: const Text(
                    "4576673 581 / Kaynarca",
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {},
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
                AppStrings.availableBalance,
                style: TextStyle(color: Colors.grey.shade300),
              ),
              Padding(
                padding: PaddingConstant.paddingOnlyTop,
                child: Text(
                  _isVisible ? "345,34 TL" : "***,**",
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
                    _actions.length,
                    (index) => Column(
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
                          child: _actions[index].icon,
                        ),
                        Text(
                          _actions[index].actionsName,
                          textAlign: TextAlign.center,
                          style: context.textTheme.titleSmall?.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: PaddingConstant.paddingOnlyTopHigh,
                sliver: _isVisible
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return ListTile(
                              minVerticalPadding: 20,
                              shape: const Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
                              title: const Text("Kredi Kartı Ödemesi"),
                              subtitle: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Do consequat enim fugiat laboris."),
                                  Text("22 Ağustos 2024"),
                                ],
                              ),
                              trailing: Text(
                                "34,15 TL",
                                style: context.textTheme.titleMedium,
                              ),
                            );
                          },
                          childCount: 10,
                        ),
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
