import 'package:denizbank_clone/core/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class FastTransactionsScreen extends StatefulWidget {
  const FastTransactionsScreen({super.key});

  @override
  State<FastTransactionsScreen> createState() => _FastTransactionsScreenState();
}

class _FastTransactionsScreenState extends State<FastTransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
    );
  }
}
