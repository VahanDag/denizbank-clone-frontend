import 'package:denizbank_clone/core/extensions.dart';
import 'package:denizbank_clone/core/paddings_borders.dart';
import 'package:flutter/material.dart';

class PageRouters extends StatefulWidget {
  const PageRouters({super.key});

  @override
  State<PageRouters> createState() => _PageRoutersState();
}

class _PageRoutersState extends State<PageRouters> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final TabBar _tabbar;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabbar = TabBar(
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        indicatorWeight: 3,
        indicatorColor: Colors.white,
        indicatorPadding: PaddingConstant.paddingOnlyTopLow,
        unselectedLabelColor: Colors.grey.shade400,
        controller: _tabController,
        tabs: [Text("Bireysel".toUpperCase()), Text("Kurumsal".toUpperCase())]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Container(
            height: context.deviceHeight * 0.55,
            color: Colors.blue,
            child: Column(
              children: [
                Padding(
                  padding: PaddingConstant.paddingAllHigh,
                  child: Row(
                    children: [
                      Image.asset(width: 150, "assets/images/denizbank.png"),
                      const Spacer(),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.circle_outlined)),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_active)),
                    ],
                  ),
                ),
                Container(margin: PaddingConstant.paddingOnlyBottomHigh, width: context.deviceWidth * 0.6, child: _tabbar),
                Expanded(
                    child: TabBarView(controller: _tabController, children: const [IndividualUsers(), Text("Kurumsal")]))
              ],
            ),
          ),
          Container(
            margin: PaddingConstant.paddingVerticalHigh,
            height: 75,
            child: ListView.builder(
              itemCount: 6,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 75,
                  width: 75,
                  margin: PaddingConstant.paddingHorizontal,
                  padding: PaddingConstant.paddingAll,
                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.red, width: 2)),
                  child: Image.asset("assets/images/denizbank.png"),
                );
              },
            ),
          ),
          SizedBox(
            height: 125,
            child: ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: PaddingConstant.paddingHorizontal,
                  elevation: 5,
                  child: Container(
                    width: 300,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(borderRadius: BorderRadiusConstant.borderRadius, color: Colors.white),
                    child: ListTile(
                      leading: const Icon(
                        Icons.trending_up,
                        size: 50,
                      ),
                      title: Text(
                        "Piyasalar",
                        style: context.textTheme.titleMedium,
                      ),
                      subtitle: const Text("Tüm piyasa verilerine buradan ulaşın."),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}

class IndividualUsers extends StatelessWidget {
  const IndividualUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(radius: 40, child: Icon(Icons.person, size: 50)),
        const Column(
          children: [
            Text("Hoşgeldiniz!"),
            Text("Vahan Dağ"),
          ],
        ),
        Container(
          margin: PaddingConstant.paddingVerticalMedium,
          alignment: Alignment.center,
          width: context.deviceWidth * 0.5,
          height: 35,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadiusConstant.borderRadiusLow),
          child: Text("Giriş yapın".toUpperCase(),
              style: context.textTheme.titleMedium?.copyWith(color: Colors.blue, fontWeight: FontWeight.bold)),
        ),
        Text("Farklı Kullanıcı ile Giriş Yapın", style: context.textTheme.titleMedium?.copyWith(color: Colors.white))
      ],
    );
  }
}
