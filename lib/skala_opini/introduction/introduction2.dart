import 'package:flutter/material.dart';

class Introduction2 extends StatefulWidget {
  const Introduction2({super.key});

  @override
  State<Introduction2> createState() => _Introduction2State();
}

class _Introduction2State extends State<Introduction2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBar(
        title: const Text("Intro 2 "),
      ),
    );
  }
}
