import 'package:denizbank_clone/core/constants/app_strings.dart';
import 'package:denizbank_clone/core/constants/extensions.dart';
import 'package:denizbank_clone/core/constants/paddings_borders.dart';
import 'package:denizbank_clone/core/widgets/custom_appbar.dart';
import 'package:denizbank_clone/models/widget_models.dart';
import 'package:denizbank_clone/screens/menu/bank_cards.dart';
import 'package:denizbank_clone/screens/menu/widgets/menu_widgets.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MenuScreen extends StatelessWidget {
  MenuScreen({super.key});
  final List<ActionsModel> _otherTransactions = [
    ActionsModel(actionsName: "Hesaplar", routeTo: const SizedBox()),
    ActionsModel(actionsName: "Kartlar", routeTo: const UserBankCards()),
    ActionsModel(actionsName: "Krediler", routeTo: const SizedBox()),
    ActionsModel(actionsName: "Yatırım İşlemleri", routeTo: const SizedBox()),
    ActionsModel(actionsName: "Döviz ve Kıymetli Madenler", routeTo: const SizedBox()),
    ActionsModel(actionsName: "Diğer Banka İşlemleri", routeTo: const SizedBox()),
    ActionsModel(actionsName: "Kampanyalar", routeTo: const SizedBox()),
    ActionsModel(actionsName: "QR İşlemleri", routeTo: const SizedBox()),
    ActionsModel(actionsName: "Sigortalarım", routeTo: const SizedBox()),
    ActionsModel(actionsName: "Bireysel Emeklilik(BES) İşlemleri", routeTo: const SizedBox()),
    ActionsModel(actionsName: "Onay Bekleyen İşlemler", routeTo: const SizedBox()),
    ActionsModel(actionsName: "Üye İşyeri İşlemleri", routeTo: const SizedBox()),
    ActionsModel(actionsName: "Kurumsal Onay İşlemleri", routeTo: const SizedBox()),
    ActionsModel(actionsName: "Çek / Senet İşlemleri", routeTo: const SizedBox()),
    ActionsModel(actionsName: "Profil ve Ayarlar", routeTo: const SizedBox()),
    ActionsModel(actionsName: "E-Devlet Girişi", routeTo: const SizedBox()),
  ];

  static final List<ActionsModel> _fastTransactions = [
    ActionsModel(actionsName: "Başka Hesaba \nPara Gönder", icon: Icon(size: 26, MdiIcons.cubeSend)),
    ActionsModel(actionsName: AppStrings.payBill2Line, icon: Icon(size: 26, MdiIcons.receiptTextOutline)),
    ActionsModel(actionsName: "Kolay Adres \nİşlemleri", icon: Icon(size: 26, MdiIcons.textBoxCheckOutline)),
    ActionsModel(actionsName: "Kart \nBorcu", icon: Icon(size: 26, MdiIcons.receiptTextOutline)),
    ActionsModel(actionsName: "QR ile Para \nÇek / Yatır", icon: Icon(size: 26, MdiIcons.qrcode)),
    ActionsModel(actionsName: "Şans \nOyunları", icon: const Icon(size: 26, Icons.gamepad_outlined)),
    ActionsModel(actionsName: "Kredi \nBaşvurusu", icon: Icon(size: 26, MdiIcons.handCoinOutline)),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          Padding(
            padding: PaddingConstant.paddingOnlyRightHigh,
            child: Icon(
              MdiIcons.chatQuestionOutline,
              color: Colors.white,
              size: 25,
            ),
          )
        ],
        title: Text(
          "menü".toUpperCase(),
          style:
              context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.5),
        ),
        height: 120,
        bottom: Padding(
          padding: PaddingConstant.paddingHorizontalHigh.copyWith(bottom: 15),
          child: SizedBox(
            height: 50,
            child: SearchBar(
              hintText: "Ara",
              leading: Icon(
                Icons.search,
                size: 25,
                color: Colors.blue.shade400,
              ),
              hintStyle: const WidgetStatePropertyAll(TextStyle(color: Colors.grey)),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadiusConstant.borderRadius)),
            ),
          ),
        ),
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              MdiIcons.accountCogOutline,
              size: 25,
              color: Colors.white,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: PaddingConstant.paddingHorizontalMedium,
              child: Row(
                children: [
                  const Text("Hızlı İşlemler"),
                  const Spacer(),
                  TextButton(onPressed: () {}, child: const Text("Düzenle"))
                ],
              ),
            ),
            SizedBox(
              height: 85,
              child: ListView.builder(
                padding: PaddingConstant.paddingOnlyBottom,
                scrollDirection: Axis.horizontal,
                itemCount: _fastTransactions.length,
                itemBuilder: (BuildContext context, int index) {
                  return actionsCard(context, _fastTransactions[index]);
                },
              ),
            ),
            Padding(
              padding: PaddingConstant.paddingOnlyLeftMedium.copyWith(top: 30, bottom: 10),
              child: Text(
                "Diğer İşlemler",
                style: context.textTheme.titleMedium?.copyWith(color: Colors.blue),
              ),
            ),
            ...List.generate(
              _otherTransactions.length,
              (index) => ListTile(
                shape: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
                onTap: () =>
                    Navigator.push(context, MaterialPageRoute(builder: (context) => _otherTransactions[index].routeTo!)),
                title: Text(
                  _otherTransactions[index].actionsName,
                  style: context.textTheme.titleMedium,
                ),
                trailing: const Icon(Icons.chevron_right_rounded),
              ),
            )
          ],
        ),
      ),
    );
  }
}
