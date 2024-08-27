import 'package:denizbank_clone/core/constants/enums.dart';
import 'package:denizbank_clone/cubit/auth/auth_cubit.dart';
import 'package:denizbank_clone/cubit/routers/routers_cubit.dart';
import 'package:denizbank_clone/screens/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(AuthStatus.authenticated),
        ),
        BlocProvider(
          create: (context) => RoutersCubit(true),
        )
      ],
      child: const MyApp(),
    ));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: BlocBuilder<AuthCubit, AuthStatus>(
        builder: (context, state) {
          return const BottomNavBar();
        },
      ),
    );
  }
}
