import 'package:flutter/material.dart';
import 'package:manga_app/contant/tag_colors.dart';
import 'package:manga_app/model/manga.dart';
import 'package:manga_app/theme/size.dart';
import 'package:manga_app/theme/text_style.dart';
import 'package:manga_app/utils/list.dart';
import 'package:manga_app/utils/map.dart';
import 'package:manga_app/widget/tag/tag.dart';
import 'package:manga_app/widget/text/text.dart';
import 'package:manga_app/widget/image/image_loader.dart';

const _maxLineName = 1;

class HomeNominationItem extends StatelessWidget {
  final Manga? manga;
  final void Function(String? url)? onTap;

  const HomeNominationItem({
    Key? key,
    this.manga,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(manga?.url),
      child: _cardItemBuilder(
        context: context,
        title: manga?.name ?? "",
        headers: [
          {"content": manga?.newChapter, "icon": "name"},
          {"content": manga?.timeUpdate, "icon": "timer"}
        ].list(
          process: (content) => MTag(
            radius: containerRadius,
            padding: const EdgeInsets.all(2),
            margin: const EdgeInsets.all(4).copyWith(bottom: 0),
            background: tagColor().withOpacity(0.6),
            icon: Icon(
              content.getOrNull("icon") == "timer"
                  ? Icons.timer_outlined
                  : Icons.numbers_outlined,
              size: 12,
              color: Colors.white,
            ),
            content: MText(
              text: content.getOrNull("content"),
              style: context.bodySuperSmall.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _cardItemBuilder({
    required BuildContext context,
    required List<Widget> headers,
    required String title,
  }) {
    return Container(
      width: thumbWidth,
      height: thumbHeight,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          containerRadius,
        ),
        image: DecorationImage(
          image: MangaImageProvider(
            imageUrl: manga?.thumb,
            referer: manga?.referer,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: headers,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              width: thumbWidth,
              padding: const EdgeInsets.all(4).copyWith(top: 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black,
                  ],
                ),
              ),
              child: MText(
                text: title,
                maxLines: _maxLineName,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: context.titleSmall.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
