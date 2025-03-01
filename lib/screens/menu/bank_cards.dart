import 'package:denizbank_clone/core/constants/app_strings.dart';
import 'package:denizbank_clone/core/constants/extensions.dart';
import 'package:denizbank_clone/core/constants/paddings_borders.dart';
import 'package:denizbank_clone/core/widgets/custom_appbar.dart';
import 'package:denizbank_clone/models/widget_models.dart';
import 'package:denizbank_clone/screens/menu/widgets/menu_widgets.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class UserBankCards extends StatelessWidget {
  const UserBankCards({super.key});

  @override
  Widget build(BuildContext context) {
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
                            margin: PaddingConstant.paddingHorizontalLow,
                            height: 75,
                            context,
                            ActionsModel(actionsName: "Kart Başvurusu", icon: Icon(MdiIcons.creditCardFast)))),
                    Expanded(
                        child: actionsCard(
                            margin: PaddingConstant.paddingHorizontalLow,
                            height: 75,
                            context,
                            ActionsModel(actionsName: "Kart İşlemleri", icon: Icon(MdiIcons.creditCardFast))))
                  ],
                ).margin(PaddingConstant.paddingVerticalHigh),
                Text(
                  "Kredi Kartlarım (2)",
                  style: context.textTheme.titleMedium?.copyWith(color: Colors.blueGrey),
                ).margin(PaddingConstant.paddingVerticalHigh),
                _userDebitCreditCard(
                    context: context,
                    cardName: "DenizBank Black MasterCard",
                    image: "assets/images/black_card.png",
                    subTitle: [
                      {"title": "Kullanılabilir Limit", "value": "1234.56 TL"},
                      {"title": "Ekstreden Kalan Borç", "value": "1234.56 TL"},
                    ]),
                _userDebitCreditCard(
                    context: context,
                    cardName: "Anında Sanal Kart",
                    image: "assets/images/black_card.png",
                    subTitle: [
                      {"title": "Kullanılabilir Limit", "value": "1234.56 TL"},
                      {"title": "Son Kullanma Tarihi", "value": "11/26"},
                      {"title": "Güvenlik Kodu(CVV)", "value": "554"},
                    ])
              ],
            ),
          ),
        ),
      ),
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
                Image.asset(height: 75, fit: BoxFit.cover, image),
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
