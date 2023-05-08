import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});
  static const String name = "/category";

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white70,
        child: Stack(
          children: const [
            Center(
              child: Text("category", style: TextStyle(fontSize: 24, color: Colors.red)),
            )
          ],
        ),
      ),
    );
  }
}