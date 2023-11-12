import 'package:flutter/material.dart';

class ImageTextWidget extends StatelessWidget {
  final String image;
  final String text;
  const ImageTextWidget({required this.image, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(image),
        const SizedBox(
          width: 5,
        ),
        Text(text)
      ],
    );
  }
}