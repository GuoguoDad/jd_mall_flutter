import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});
  static const String name = "/mine";

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white70,
        child: Stack(
          children: const [
            Center(
              child: Text("mine"),
            )
          ],
        ),
      ),
    );
  }
}