import 'package:flutter/material.dart';
import 'package:manga_app/widget/divider/divider.dart';
import 'package:manga_app/widget/text/text.dart';

class MTitle extends StatelessWidget {
  final double? space;
  final Widget? icon;
  final String title;
  final TextStyle? titleStyle;
  final int? maxLines;

  const MTitle({
    Key? key,
    this.icon,
    this.space,
    this.titleStyle,
    this.maxLines,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Padding(
            padding: EdgeInsets.only(
              right: space ?? 0,
            ),
            child: icon!,
          ),
        ],
        MText(
          text: title,
          style: titleStyle,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }
}
