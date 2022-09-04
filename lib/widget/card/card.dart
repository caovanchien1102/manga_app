import 'package:flutter/material.dart';
import 'package:manga_app/theme/size.dart';

class MCard extends StatelessWidget {
  final Widget child;
  final Widget? header;

  final bool noDivider;
  final bool noPadding;

  const MCard({
    Key? key,
    required this.child,
    this.header,
    this.noDivider = false,
    this.noPadding = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(
        noDivider ? 0 : containerMargin,
      ).copyWith(bottom: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          containerRadius,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (header != null) header!,
          Padding(
            padding: EdgeInsets.all(
              noPadding ? 0 : containerPadding,
            ),
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  containerRadius,
                ),
              ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
