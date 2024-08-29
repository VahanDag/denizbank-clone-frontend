import 'package:denizbank_clone/core/constants/extensions.dart';
import 'package:denizbank_clone/core/constants/paddings_borders.dart';
import 'package:denizbank_clone/core/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

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
              size: 30,
            ),
          )
        ],
        title: Text(
          "menü".toUpperCase(),
          style:
              context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.5),
        ),
        height: 130,
        bottom: Padding(
          padding: PaddingConstant.paddingHorizontalHigh.copyWith(bottom: 15),
          child: SearchBar(
            hintText: "Ara",
            leading: Icon(
              Icons.search,
              size: 30,
              color: Colors.blue.shade400,
            ),
            hintStyle: const WidgetStatePropertyAll(TextStyle(color: Colors.grey)),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadiusConstant.borderRadius)),
          ),
        ),
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              MdiIcons.accountCogOutline,
              size: 30,
              color: Colors.white,
            )),
      ),
      body: Column(
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
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 5,
                  margin: PaddingConstant.paddingHorizontal,
                  child: SizedBox(
                    width: 180,
                    child: ListTile(
                      contentPadding: PaddingConstant.paddingAll,
                      title: Text(
                        "Başka Hesaba Para Gönder",
                        style: context.textTheme.titleSmall,
                      ),
                      leading: Icon(MdiIcons.cubeSend, size: 40, color: Colors.blue.shade600),
                    ),
                  ),
                );
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
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  shape: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
                  onTap: () {},
                  title: Text(
                    "Hesaplar",
                    style: context.textTheme.titleMedium,
                  ),
                  trailing: const Icon(Icons.chevron_right_rounded),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
