import 'package:denizbank_clone/core/constants/app_colors.dart';
import 'package:denizbank_clone/core/constants/app_strings.dart';
import 'package:denizbank_clone/core/constants/enums.dart';
import 'package:denizbank_clone/core/constants/extensions.dart';
import 'package:denizbank_clone/core/constants/paddings_borders.dart';
import 'package:denizbank_clone/core/widgets/custom_appbar.dart';
import 'package:denizbank_clone/cubit/cards/cards_cubit.dart';
import 'package:denizbank_clone/models/card_model.dart';
import 'package:denizbank_clone/models/widget_models.dart';
import 'package:denizbank_clone/screens/cards/create_card_screen.dart';
import 'package:denizbank_clone/screens/menu/widgets/menu_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class UserBankCards extends StatelessWidget {
  const UserBankCards({super.key});

  @override
  Widget build(BuildContext context) {
    final cards = context.watch<CardsCubit>().state.cards;

    return Scaffold(
      appBar: CustomAppBar(
        title: appBarTitle(AppStrings.cards),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: context.deviceWidth * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: actionsCard(
                          onTap: () =>
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateCardScreen())),
                          margin: PaddingConstant.paddingHorizontalLow,
                          height: 75,
                          context,
                          ActionsModel(
                              actionsName: "Kart\nBaşvurusu",
                              icon: Icon(MdiIcons.creditCardOutline, color: AppColors.mainBlue))),
                    ),
                    Expanded(
                      child: actionsCard(
                          margin: PaddingConstant.paddingHorizontalLow,
                          height: 75,
                          context,
                          ActionsModel(
                              actionsName: "Kart\nİşlemleri",
                              icon: Icon(MdiIcons.creditCardMinusOutline, color: AppColors.mainBlue))),
                    )
                  ],
                ).margin(PaddingConstant.paddingVerticalHigh),
                crateCardsWithCardType(cardType: CardTypeEnum.Credit, cards: cards, context: context),
                crateCardsWithCardType(cardType: CardTypeEnum.Debit, cards: cards, context: context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget crateCardsWithCardType(
      {required BuildContext context, required CardTypeEnum cardType, required List<CardModel> cards}) {
    final cardsWithType = cards.where((card) => card.cardType.cardType == cardType).toList();
    final bool isCredit = cardType == CardTypeEnum.Credit;
    return cardsWithType.isEmpty
        ? const SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${isCredit ? 'Kredi' : 'Banka'} Kartlarım (${cardsWithType.length})",
                style: context.textTheme.titleMedium?.copyWith(color: Colors.blueGrey),
              ).margin(PaddingConstant.paddingVerticalHigh),
              ...List.generate(
                  cardsWithType.length,
                  (index) => _userDebitCreditCard(
                          context: context,
                          cardName: cardsWithType[index].cardType.cardName,
                          image: cardsWithType[index].cardType.imageURI,
                          subTitle: [
                            {
                              "title": isCredit ? "Kullanılabilir Limit" : "Bakiye",
                              "value": "${isCredit ? cardsWithType[index].balanceLimit : cardsWithType[index].balance} TL"
                            },
                            {"title": "Son Kullanım Tarihi", "value": cardsWithType[index].expirationDate},
                            if (isCredit) {"title": "Kalan Borç", "value": "${cardsWithType[index].debt} TL"},
                          ]))
            ],
          );
  }

  Card _userDebitCreditCard(
      {required BuildContext context,
      required String cardName,
      required String image,
      required List<Map<String, dynamic>> subTitle}) {
    return Card(
      elevation: 2,
      margin: PaddingConstant.paddingOnlyBottomHigh,
      color: Colors.white,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Image.network(height: 75, fit: BoxFit.cover, image),
                Flexible(
                  child: ListTile(
                    title: Text(
                      cardName,
                      style: context.textTheme.titleMedium,
                    ),
                    subtitle: _subText(context, "0234*** **** 3467"),
                    trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 30),
                  ),
                )
              ],
            ).margin(PaddingConstant.paddingOnlyTopMedium),
            ...subTitle
                .map((e) => _cardInfoRow(context, e["title"], e["value"]).margin(PaddingConstant.paddingOnlyBottomLow)),
          ],
        ),
      ),
    );
  }

  Widget _cardInfoRow(BuildContext context, String title, String value) {
    return Row(
      children: [
        _subText(context, title),
        const Spacer(),
        Text(
          value,
          style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.grey.shade800),
        )
      ],
    ).margin(PaddingConstant.paddingHorizontalHigh.copyWith(top: 5, bottom: 5));
  }

  Text _subText(BuildContext context, String title) => Text(
        title,
        style: context.textTheme.titleSmall?.copyWith(color: Colors.grey),
      );
}
