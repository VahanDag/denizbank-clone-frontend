import 'package:denizbank_clone/core/constants/app_strings.dart';
import 'package:denizbank_clone/core/constants/extensions.dart';
import 'package:denizbank_clone/core/constants/paddings_borders.dart';
import 'package:denizbank_clone/core/widgets/coming_soon.dart';
import 'package:denizbank_clone/core/widgets/custom_bottomsheet.dart';
import 'package:denizbank_clone/core/widgets/custom_buttons.dart';
import 'package:denizbank_clone/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        HomeAndLoginTopArea(
          otherWidgets: const [],
          height: 0.55,
          tabWidth: 0.6,
          tabs: [Text(AppStrings.individual.toUpperCase()), Text(AppStrings.institutional.toUpperCase())],
          tabChildren: [const IndividualUsers(), Center(child: comingSoon())],
        ),
        Container(
          margin: PaddingConstant.paddingVerticalHigh.copyWith(bottom: 5),
          height: 120,
          child: ListView.builder(
            itemCount: 6,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: PaddingConstant.paddingHorizontalLow,
                width: 100,
                child: Column(
                  children: [
                    Container(
                      height: 75,
                      width: 75,
                      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.red, width: 2)),
                      child: Image.asset("assets/images/denizbank.png"),
                    ),
                    Text(
                      "Yenilenen MobilDeniz ile artık çok kolay",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: context.textTheme.labelSmall,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 100,
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
                      size: 40,
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
    ));
  }
}

class HomeAndLoginTopArea extends StatefulWidget {
  const HomeAndLoginTopArea(
      {super.key,
      required List<Widget> tabs,
      required List<Widget> tabChildren,
      required this.otherWidgets,
      required this.tabWidth,
      required this.height})
      : _tabs = tabs,
        _tabChildren = tabChildren;

  final List<Widget> _tabs;
  final List<Widget> _tabChildren;

  /// width should be between 0.0 and 1.0
  final double tabWidth;
  final double height;
  final List<Widget> otherWidgets;

  @override
  State<HomeAndLoginTopArea> createState() => _HomeAndLoginTopAreaState();
}

class _HomeAndLoginTopAreaState extends State<HomeAndLoginTopArea> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final TabBar _tabbar;

  @override
  void initState() {
    _tabController = TabController(length: widget._tabs.length, vsync: this);
    _tabbar = TabBar(
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        indicatorWeight: 3,
        indicatorColor: Colors.white,
        indicatorPadding: PaddingConstant.paddingOnlyTopLow,
        unselectedLabelColor: Colors.grey.shade400,
        controller: _tabController,
        tabs: widget._tabs);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: context.deviceHeight * 0.20,
          width: double.infinity,
          color: const Color(0xff367cde),
          child: Column(
            children: [
              Padding(
                padding: PaddingConstant.paddingAllHigh,
                child: Row(
                  children: [
                    Image.asset(width: 150, "assets/images/denizbank.png"),
                    const Spacer(),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.circle_outlined, color: Colors.white)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_active_outlined, color: Colors.white)),
                  ],
                ),
              ),
              Container(
                  margin: PaddingConstant.paddingOnlyBottomHigh,
                  width: context.deviceWidth * widget.tabWidth,
                  child: _tabbar),
            ],
          ),
        ),
        Expanded(child: TabBarView(controller: _tabController, children: widget._tabChildren))
      ],
    );
  }
}

class IndividualUsers extends StatelessWidget {
  const IndividualUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(backgroundColor: Colors.white, radius: 40, child: Icon(Icons.person_2_outlined, size: 50)),
        const Padding(
          padding: PaddingConstant.paddingOnlyTopLow,
          child: Column(
            children: [
              Text(
                AppStrings.welcome,
                style: TextStyle(color: Colors.white),
              ),
              Text("Vahan Dağ", style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        CustomButton(
            margin: PaddingConstant.paddingVertical,
            textColor: Colors.blue,
            buttonColor: Colors.white,
            onPressed: () => customBottomSheet(
                context: context, title: AppStrings.individualLogin, child: const LoginSheetChild(), height: 0.8),
            text: AppStrings.login),
        Text(AppStrings.loginWithOther, style: context.textTheme.titleMedium?.copyWith(color: Colors.white))
      ],
    );
  }
}

class LoginSheetChild extends StatefulWidget {
  const LoginSheetChild({
    super.key,
  });

  @override
  State<LoginSheetChild> createState() => _LoginSheetChildState();
}

class _LoginSheetChildState extends State<LoginSheetChild> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ListTile(
          leading: CircleAvatar(
            child: Icon(Icons.person_2_outlined),
          ),
          title: Text("Vahan Dağ"),
        ),
        const Divider(),
        Container(
          margin: PaddingConstant.paddingAllHigh,
          decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadiusConstant.borderRadiusMedium),
          child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              labelPadding: PaddingConstant.paddingAll,
              labelColor: Colors.white,
              dividerColor: Colors.transparent,
              unselectedLabelColor: Colors.grey.shade700,
              indicator: BoxDecoration(color: Colors.blue, borderRadius: BorderRadiusConstant.borderRadius),
              controller: _tabController,
              tabs: const [Text(AppStrings.loginWithPaint), Text(AppStrings.loginWithPassword)]),
        ),
        SizedBox(
          height: 250,
          child: TabBarView(controller: _tabController, children: [
            Center(child: comingSoon(textColor: Colors.blueGrey)),
            Column(
              children: [
                Padding(
                  padding: PaddingConstant.paddingHorizontalHigh,
                  child: Column(
                    children: [
                      const Align(alignment: Alignment.centerLeft, child: Text(AppStrings.password)),
                      CustomTextField(
                        controller: _passwordController,
                        margin: PaddingConstant.paddingVerticalLow,
                        hintText: AppStrings.pleaseEnter,
                        isPassword: true,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {},
                              child: Text(
                                AppStrings.forgotPassword,
                                style: context.textTheme.titleSmall,
                              ))),
                    ],
                  ),
                ),
                CustomButton(
                    margin: PaddingConstant.paddingAllHigh, height: 50, width: 1, onPressed: () {}, text: AppStrings.login),
              ],
            )
          ]),
        )
      ],
    );
  }
}
