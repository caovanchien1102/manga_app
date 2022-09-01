import 'package:flutter/material.dart';
import 'package:manga_app/widget/divider/divider.dart';

class MCard extends StatelessWidget {
  final Widget child;
  final Widget? header;

  final bool noDivider;
  final bool noSpacer;
  final bool noPadding;

  const MCard({
    Key? key,
    required this.child,
    this.header,
    this.noDivider = false,
    this.noSpacer = true,
    this.noPadding = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(
        noDivider ? 0 : 8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (header != null) ...[
            Padding(
              padding: EdgeInsets.all(
                noPadding ? 0 : 8,
              ).copyWith(bottom: 0),
              child: header ?? const SizedBox.shrink(),
            ),
            MDivider(
              height: noSpacer ? 0 : 8,
            )
          ],
          Padding(
            padding: EdgeInsets.all(
              noPadding ? 0 : 8,
            ),
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
