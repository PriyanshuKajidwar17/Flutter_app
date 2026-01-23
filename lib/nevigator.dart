import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Page"),
      ),
      body: const Center(
        child: Text(
          "Error 404 😂 Code is running..",
          style: TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
