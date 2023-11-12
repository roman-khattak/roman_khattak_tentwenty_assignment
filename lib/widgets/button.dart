import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final double width;
  final String text;
  const Button({required this.width, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: width,
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(
          text,
          style:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}