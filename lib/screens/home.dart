import 'package:denizbank_clone/core/constants/app_strings.dart';
import 'package:denizbank_clone/core/constants/extensions.dart';
import 'package:denizbank_clone/core/constants/paddings_borders.dart';
import 'package:denizbank_clone/screens/login.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HomeAndLoginTopArea(
            height: 0.4,
            tabWidth: 1,
            tabs: [_tabTexts(AppStrings.accounts), _tabTexts(AppStrings.cards), _tabTexts(AppStrings.financialSummary)],
            tabChildren: const [Accounts(), Text("data"), Text("data")],
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  collapsedHeight: 120,
                  primary: false,
                  floating: true,
                  backgroundColor: const Color(0xff367cde),
                  flexibleSpace: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      4,
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
                            child: const Icon(Icons.qr_code, color: Colors.white),
                          ),
                          Text(
                            AppStrings.sendMoney2line,
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
                  sliver: SliverList(
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
                      childCount: 50,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Text _tabTexts(String text) => Text(
        text.toUpperCase(),
        maxLines: 1,
      );
}

class Accounts extends StatelessWidget {
  const Accounts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: PaddingConstant.paddingHorizontalHigh.copyWith(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.blue.shade300.withOpacity(0.6),
            borderRadius: BorderRadiusConstant.borderRadius,
          ),
          child: ListTile(
            title: const Text(
              "Vahan Dağ",
              style: TextStyle(color: Colors.white),
            ),
            subtitle: const Text(
              "4576673 581 / Kaynarca",
              style: TextStyle(color: Colors.white),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.visibility_outlined,
                color: Colors.white70,
              ),
            ),
          ),
        ),
        Text(
          AppStrings.availableBalance,
          style: TextStyle(color: Colors.grey.shade300),
        ),
        Padding(
          padding: PaddingConstant.paddingVerticalLow,
          child: Text(
            "345,34 TL",
            style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
