import 'package:denizbank_clone/cubit/auth/auth_state.dart';
import 'package:denizbank_clone/cubit/auth/auth_cubit.dart';
import 'package:denizbank_clone/cubit/cards/cards_cubit.dart';
import 'package:denizbank_clone/cubit/routers/routers_cubit.dart';
import 'package:denizbank_clone/cubit/transaction/transaction_cubit.dart';
import 'package:denizbank_clone/cubit/user/user_cubit.dart';
import 'package:denizbank_clone/screens/routers.dart';
import 'package:denizbank_clone/service/auth_service.dart';
import 'package:denizbank_clone/service/card_service.dart';
import 'package:denizbank_clone/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final authService = AuthService(baseUrl: 'http://10.0.2.2:5017');
  final isAuthenticated = await authService.hasValidToken();
  final userService = UserService(baseUrl: 'http://10.0.2.2:5017', authService: authService);
  final cardService = CardService(baseUrl: 'http://10.0.2.2:5017', authService: authService);

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => UserCubit(userService: userService)),
      BlocProvider(create: (context) => CardsCubit(cardService)),
      BlocProvider(create: (context) => TransactionCubit(cardService)),
      BlocProvider(
        create: (context) => AuthCubit(
          authService: authService,
          userCubit: context.read<UserCubit>(),
        ),
      ),
      BlocProvider(
        create: (context) => RoutersCubit(isAuthenticated),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            print("Auth State Changed: $state");

            final routersCubit = context.read<RoutersCubit>();
            if (state is AuthAuthenticated) {
              print("Auth State is Authenticated, updating RoutersCubit");
              routersCubit.updateAuthStatus(true);

              // Kullanıcı kimliği doğrulandığında kullanıcı bilgilerini kontrol et
              final userCubit = context.read<UserCubit>();
              if (userCubit.state.user == null) {
                userCubit.loadUser();
              }

              // Kartları yükle
              final cardsCubit = context.read<CardsCubit>();
              cardsCubit.loadCards();
              print("cards loaded");

              // İşlemleri yükle
              final transactionCubit = context.read<TransactionCubit>();
              transactionCubit.loadAllTransactions();
            } else if (state is AuthUnauthenticated) {
              print("Auth State is Unauthenticated, updating RoutersCubit");
              routersCubit.updateAuthStatus(false);
            }
          },
        ),
        BlocListener<RoutersCubit, RoutersState>(
          listener: (context, state) {
            print("Router State Changed: $state");
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xfffafafa),
          colorScheme: const ColorScheme.light(
            surface: Colors.white,
          ),
        ),
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            // Initial ve AppLoading durumlarında splash ekranını göster
            if (state is AuthInitial || state is AuthAppLoading) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            // Diğer durumlar için normal ekranı göster
            return const BottomNavBar();
          },
        ),
      ),
    );
  }
}
