import 'package:denizbank_clone/core/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: appBarTitle("para gönder")),
      body: Container(
        child: const Center(
          child: Text("Send Money Screen"),
        ),
      ),
    );
  }
}
