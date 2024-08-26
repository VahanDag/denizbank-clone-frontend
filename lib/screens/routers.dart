import 'package:denizbank_clone/core/constants/extensions.dart';
import 'package:denizbank_clone/core/constants/paddings_borders.dart';
import 'package:denizbank_clone/cubit/routers/routers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  // void cubit.changeItem(String item) {
  //   setState(() {
  //     _selectedItem = item;
  //     cubit.selectedItemIndex = cubit.titles.indexOf(item);
  //   });
  // }

  @override
  void initState() {
    // cubit.selectedItemIndex = -1;
    super.initState();
  }

  // void _setPageToInitialPage() {
  //   setState(() {
  //     cubit.selectedItemIndex = -1;
  //     _selectedItem = "initial";
  //   });
  // }

  static final List<Color> _selectedColors = [
    Colors.blue.shade800,
    Colors.blue,
  ];

  static final List<Color> _unSelectedColors = [
    Colors.red,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RoutersCubit, RoutersState>(
      listener: (context, state) {
        if (state is RoutersInitial) {
          final cubit = context.read<RoutersCubit>();

          cubit.selectedItemIndex = -1;
          cubit.selectedItem = "initial";
        }
      },
      builder: (context, state) {
        final cubit = context.read<RoutersCubit>();
        return Scaffold(
          body: cubit.selectedItemIndex == -1 ? cubit.pages.last : cubit.pages[cubit.selectedItemIndex],
          bottomNavigationBar: SizedBox(
            width: 200,
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                cubit.isAuth
                    ? _icons(cubit: cubit, title: cubit.titles.first, icon: Icons.home)
                    : _icons(
                        cubit: cubit,
                        onTap: () {
                          cubit.changeItem(0);
                        },
                        title: cubit.titles.first,
                        imagePath: "assets/images/fast-service.png",
                      ),
                _icons(
                    cubit: cubit,
                    onTap: () => cubit.changeItem(1),
                    title: cubit.titles[1],
                    icon: Icons.library_books_outlined),
                GestureDetector(
                  onTap: () => cubit.changeItem(2),
                  child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: PaddingConstant.paddingOnlyBottom,
                      padding: PaddingConstant.paddingAllLow.copyWith(left: 15, right: 15),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft,
                              colors: cubit.selectedItem == cubit.titles[2] ? _selectedColors : _unSelectedColors)),
                      child: Column(
                        children: [
                          Icon(
                            MdiIcons.shipWheel,
                            size: 30,
                            color: Colors.white,
                          ),
                          Text(cubit.titles[2],
                              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12))
                        ],
                      )),
                ),
                _icons(
                    cubit: cubit,
                    onTap: () => cubit.changeItem(3),
                    title: cubit.titles[3],
                    icon: Icons.account_balance_outlined),
                _icons(cubit: cubit, onTap: () => cubit.changeItem(4), title: cubit.titles[4], icon: Icons.campaign),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _icons(
      {IconData? icon, String? imagePath, required String title, void Function()? onTap, required RoutersCubit cubit}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          icon != null
              ? Icon(
                  icon,
                  size: 25,
                  color: cubit.selectedItem == title ? Colors.blue : Colors.grey,
                )
              : Image.asset(height: 25, width: 40, imagePath!),
          Text(title,
              style: context.textTheme.titleSmall?.copyWith(
                  color: cubit.selectedItem == title ? Colors.blue : Colors.grey, fontWeight: FontWeight.bold, fontSize: 12))
        ],
      ),
    );
  }
}

//  BottomNavigationBar(
//         iconSize: 32,
//         type: BottomNavigationBarType.shifting,
//         unselectedItemColor: Colors.grey,
//         selectedItemColor: Colors.blue,
//         selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
//         showUnselectedLabels: true,
//         items: [
//           BottomNavigationBarItem(
//               icon: Image.asset(height: 32, width: 32, "assets/images/fast-service.png"), label: "FAST işlemleri"),
//           const BottomNavigationBarItem(icon: Icon(Icons.library_books_outlined), label: "Başvurular"),
//           BottomNavigationBarItem(
//               icon: Container(
//                   padding: PaddingConstant.paddingAllLow.copyWith(left: 15, right: 15),
//                   decoration: const BoxDecoration(
//                       borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(20),
//                         bottomRight: Radius.circular(20),
//                       ),
//                       gradient: LinearGradient(begin: Alignment.bottomRight, end: Alignment.topLeft, colors: [
//                         Colors.red,
//                         Colors.pink,
//                       ])),
//                   child: Column(
//                     children: [
//                       Icon(
//                         MdiIcons.shipWheel,
//                         size: 40,
//                         color: Colors.white,
//                       ),
//                       const Text("Menü", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
//                     ],
//                   )),
//               label: ""),
//           const BottomNavigationBarItem(icon: Icon(Icons.account_balance_outlined), label: "Şubesiz İşlem"),
//           const BottomNavigationBarItem(icon: Icon(Icons.campaign), label: "Başvurular"),
//         ],
//       ),