import 'package:denizbank_clone/core/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class Applications extends StatelessWidget {
  const Applications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AnotherPage(), // Başka bir sayfaya geçiş
                ),
              );
            },
            child: const Text("Diğer Sayfa"),
          ),
        ],
      ),
    );
  }
}

class AnotherPage extends StatelessWidget {
  const AnotherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Diğer Sayfa")),
      body: const Center(
        child: Text("Buradasınız"),
      ),
    );
  }
}
