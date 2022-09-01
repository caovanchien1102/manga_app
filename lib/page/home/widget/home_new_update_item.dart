import 'package:flutter/material.dart';
import 'package:manga_app/contant/size.dart';
import 'package:manga_app/contant/tag_colors.dart';
import 'package:manga_app/model/manga.dart';
import 'package:manga_app/utils/list.dart';
import 'package:manga_app/widget/divider/divider.dart';
import 'package:manga_app/widget/text/text.dart';
import 'package:manga_app/widget/image/image_loader.dart';

const _maxLineName = 1;
const _maxLineDescription = 2;
const _lengthTagSupport = 8;

class HomeNewUpdateItem extends StatelessWidget {
  final Manga? manga;

  final void Function(String? url)? onTap;

  const HomeNewUpdateItem({
    Key? key,
    this.manga,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(manga?.url),
      child: _frameItem(
        context: context,
        header: [
          _itemHeader(
            context: context,
            content: manga?.chapters?.firstOrNull()?.name,
            color: Colors.green.withOpacity(0.6),
            icon: const Icon(
              Icons.numbers_outlined,
              size: 12,
              color: Colors.white,
            ),
          ),
          _itemHeader(
            context: context,
            content: manga?.timeUpdate,
            color: Colors.orange.withOpacity(0.6),
            icon: const Icon(
              Icons.timer_outlined,
              size: 12,
              color: Colors.white,
            ),
          ),
        ],
        categories: [
          for (int i = 0; i <= maxTagShow(); i++)
            _itemHeader(
              context: context,
              content:
                  i == _lengthTagSupport ? "  ...  " : manga?.categories?[i],
              color: tagColor(),
            ),
        ],
        title: manga?.name ?? "",
        description: manga?.description ?? "",
      ),
    );
  }

  Widget _frameItem({
    required BuildContext context,
    required List<Widget> categories,
    required List<Widget> header,
    required String title,
    required String description,
  }) {
    return Container(
      height: thumbHeight * 1.4,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: MangaImageProvider(
            imageUrl: manga?.thumb ?? "",
            referer: manga?.referer,
          ),
          alignment: Alignment.topCenter,
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  children: categories,
                ),
                const MDivider(
                  height: 8,
                ),
                ...header,
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8).copyWith(top: 16),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  MText(
                    text: title,
                    maxLines: _maxLineName,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  const MDivider(
                    height: 6,
                  ),
                  MText(
                    text: description,
                    maxLines: _maxLineDescription,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 8.5,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _itemHeader({
    required BuildContext context,
    required String? content,
    required Color color,
    Widget? icon,
  }) {
    if (content == null) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.only(top: 4, left: 4),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.6),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            icon,
            const MDivider(
              width: 2,
            ),
          ],
          MText(
            text: content,
            style: const TextStyle(
              fontSize: 8.5,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }

  int maxTagShow() {
    var length = manga?.categories?.length ?? 0;
    if (length > (_lengthTagSupport - 1)) {
      return _lengthTagSupport;
    }
    return length - 1;
  }
}
