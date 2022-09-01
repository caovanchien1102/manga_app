import 'package:flutter/material.dart';

class CircleTitleIcon extends StatelessWidget {
  final double size;
  final Color color;

  const CircleTitleIcon({
    Key? key,
    required this.size,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
