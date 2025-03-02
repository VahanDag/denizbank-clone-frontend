// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:denizbank_clone/core/constants/app_colors.dart';
import 'package:denizbank_clone/core/constants/enums.dart';
import 'package:denizbank_clone/core/constants/extensions.dart';
import 'package:denizbank_clone/core/constants/paddings_borders.dart';
import 'package:denizbank_clone/core/widgets/custom_appbar.dart';
import 'package:denizbank_clone/cubit/cards/cards_cubit.dart';
import 'package:denizbank_clone/models/card_model.dart';

class SelectBankAcounts extends StatelessWidget {
  const SelectBankAcounts({
    super.key,
    required this.cards,
    this.selectedCard,
  });
  final List<CardModel> cards;
  final CardModel? selectedCard;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: appBarTitle("hesaplarım")),
      body: Center(
        child: SizedBox(
          width: context.deviceWidth * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              createTilesWithTitle(cards: cards, cardType: CardTypeEnum.Debit, context: context),
              createTilesWithTitle(cards: cards, cardType: CardTypeEnum.Credit, context: context),
            ],
          ),
        ),
      ),
    );
  }

  ListTile _cardTile(BuildContext context, {CardModel? card}) {
    return ListTile(
      tileColor: selectedCard?.cardNumber == card?.cardNumber ? AppColors.mainBlue.withAlpha(40) : Colors.white,
      contentPadding: PaddingConstant.paddingHorizontal,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text(card?.cardType.cardName ?? "Hesap 1", style: context.textTheme.bodyLarge),
      subtitleTextStyle: context.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
      subtitle: GestureDetector(
        onTap: () {
          context.read<CardsCubit>().selectCard(card!);
          Navigator.pop(context);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(card?.cardNumber ?? "***"), const Text("Kullanılabilir Bakiye")],
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(onTap: () {}, child: const Icon(Icons.star_border_rounded, size: 30)),
          Text("${card?.balance} TL"),
        ],
      ),
    );
  }

  Widget createTilesWithTitle(
      {required List<CardModel> cards, required CardTypeEnum cardType, required BuildContext context}) {
    final filteredCards = cards.where((element) => element.cardType.cardType.name == cardType.name).toList();
    return Padding(
      padding: PaddingConstant.paddingVertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(getTitle(cardType), style: context.textTheme.titleMedium?.copyWith(color: AppColors.mainBlue)),
          ...List.generate(
            filteredCards.length,
            (index) => _cardTile(context, card: filteredCards[index]),
          ),
        ],
      ),
    );
  }

  String getTitle(CardTypeEnum cardType) =>
      switch (cardType) { CardTypeEnum.Debit => "Banka Kartlarım", CardTypeEnum.Credit => "Kredi Kartlarım" };
}
