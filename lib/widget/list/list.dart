import 'package:flutter/material.dart';
import 'package:manga_app/widget/divider/divider.dart';

typedef ListBuilder<TResult> = Widget Function(TResult value);

class ListGenerate<T> extends StatelessWidget {
  final List<T>? items;
  final ListBuilder? itemBuilder;
  final ListBuilder? separatedBuilder;

  final Axis direction;
  final double spacing;

  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const ListGenerate({
    Key? key,
    this.items,
    this.itemBuilder,
    this.separatedBuilder,
    this.spacing = 0.0,
    this.direction = Axis.vertical,
    this.mainAxisSize = MainAxisSize.min,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);

  List<T> get _items => items ?? <T>[];

  @override
  Widget build(BuildContext context) {
    switch (direction) {
      case Axis.horizontal:
        return Row(
          mainAxisSize: mainAxisSize,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: [
            for (int index = 0; index < _items.length; index++) ...[
              _itemBuilder(_items[index]),
              if (index != (_items.length - 1))
                if (separatedBuilder == null)
                  MDivider(
                    width: spacing,
                  )
                else ...[
                  MDivider(
                    width: spacing,
                  ),
                  _separatedBuilder(_items[index]),
                  MDivider(
                    width: spacing,
                  ),
                ],
            ],
          ],
        );
      case Axis.vertical:
        return Column(
          mainAxisSize: mainAxisSize,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: [
            for (int index = 0; index < _items.length; index++) ...[
              _itemBuilder(_items[index]),
              if (index != (_items.length - 1))
                if (separatedBuilder == null)
                  MDivider(
                    height: spacing,
                  )
                else ...[
                  MDivider(
                    height: spacing,
                  ),
                  _separatedBuilder(_items[index]),
                  MDivider(
                    height: spacing,
                  ),
                ],
            ],
          ],
        );
    }
  }

  Widget _separatedBuilder(T value) {
    if (separatedBuilder != null) {
      return separatedBuilder!(value);
    }
    return const SizedBox.shrink();
  }

  Widget _itemBuilder(T value) {
    if (itemBuilder != null) {
      return itemBuilder!(value);
    }
    return const SizedBox.shrink();
  }
}
