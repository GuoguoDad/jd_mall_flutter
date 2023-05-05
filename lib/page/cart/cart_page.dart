import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  static const String name = "/cart";

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white70,
        child: Stack(
          children: const [
            Center(
              child: Text("cart"),
            )
          ],
        ),
      ),
    );
  }
}