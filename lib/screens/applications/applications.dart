import 'package:denizbank_clone/core/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class Applications extends StatelessWidget {
  const Applications({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(appBar: CustomAppBar(), body: Center(child: Text("Yapım Aşamasında")));
  }
}
