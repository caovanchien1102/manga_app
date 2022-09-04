import 'package:flutter/material.dart';

class MTag extends StatelessWidget {
  final Widget? icon;
  final Widget? content;
  final Color? background;

  final EdgeInsets? margin;
  final EdgeInsets? padding;

  final double? radius;

  const MTag({
    Key? key,
    this.icon,
    this.content,
    this.background,
    this.margin,
    this.padding,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (content == null) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(
          radius ?? 0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Padding(
              padding: const EdgeInsets.only(
                right: 2,
              ),
              child: icon!,
            ),
          ],
          content!,
        ],
      ),
    );
  }
}
