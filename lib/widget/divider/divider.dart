import 'package:flutter/material.dart';

class MDivider extends StatelessWidget {
  final double? height;
  final double? width;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;

  final Color? color;

  final bool fill;

  const MDivider({
    Key? key,
    this.height,
    this.width,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.color,
    this.fill = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(fill == true) {
      return const Spacer();
    }
    return Container(
      width: width,
      height: height,
      color: color,
      margin: EdgeInsets.only(
        top: top ?? 0,
        bottom: bottom ?? 0,
        left: left ?? 0,
        right: right ?? 0,
      ),
    );
  }
}
