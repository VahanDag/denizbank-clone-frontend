import 'package:denizbank_clone/cubit/routers/routers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            context.read<RoutersCubit>().pageToInitial();
          },
          icon: const Icon(Icons.arrow_back)),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
