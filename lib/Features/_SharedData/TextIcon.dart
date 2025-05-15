import 'package:farming_market/utils/Resouces/ColorManager.dart';
import 'package:flutter/material.dart';

class TextIconWidget extends StatelessWidget {
  final IconData icon;
  final Widget? inBetween;
  final Text text;

  const TextIconWidget(
      {super.key, required this.icon, required this.text, this.inBetween});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: ColorManager.primary),
        const SizedBox(width: 5),
        text
      ],
    );
  }
}
