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

// class TabbbarExample extends StatefulWidget {
//   const TabbbarExample({super.key});

//   @override
//   State<TabbbarExample> createState() => _TabbbarExampleState();
// }

// class _TabbbarExampleState extends State<TabbbarExample> with SingleTickerProviderStateMixin {
//   late final TabController _tabController;

//   @override
//   void initState() {
//     _tabController = TabController(length: 2, vsync: this);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               color: Colors.blue,
//               child: TabBar(controller: _tabController, tabs: const [
//                 Text("data"),
//                 Text("data2"),
//               ]),
//             ),
//             Expanded(child: TabBarView(controller: _tabController, children: const [Text("data"), Text("data2")]))
//           ],
//         ),
//       ),
//     );
//   }
// }

class WavyHeader extends StatelessWidget {
  const WavyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _WavyHeaderPainter(),
      child: Container(
        height: 200, // Adjust this value to match your desired height
      ),
    );
  }
}

class _WavyHeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    final path = Path();

    path.lineTo(0, size.height * 0.75);

    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.7,
      size.width * 0.5,
      size.height * 0.75,
    );

    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.8,
      size.width,
      size.height * 0.75,
    );

    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Usage example
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          WavyHeader(),
          // Rest of your content
        ],
      ),
    );
  }
}
