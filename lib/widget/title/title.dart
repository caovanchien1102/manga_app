import 'package:flutter/material.dart';
import 'package:manga_app/widget/divider/divider.dart';
import 'package:manga_app/widget/text/text.dart';

class MTitle extends StatelessWidget {
  final String title;
  final double? space;
  final Widget? icon;
  final TextStyle? titleStyle;

  const MTitle({
    Key? key,
    this.icon,
    this.titleStyle,
    this.space,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (icon != null) ...[
          icon ?? const SizedBox.shrink(),
          MDivider(
            width: space,
          ),
        ],
        MText(
          text: title,
          style: titleStyle,
        )
      ],
    );
  }
}
