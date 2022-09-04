import 'package:flutter/material.dart';
import 'package:manga_app/contant/tag_colors.dart';
import 'package:manga_app/model/manga.dart';
import 'package:manga_app/theme/color_scheme.dart';
import 'package:manga_app/theme/size.dart';
import 'package:manga_app/theme/text_style.dart';
import 'package:manga_app/utils/list.dart';
import 'package:manga_app/widget/divider/divider.dart';
import 'package:manga_app/widget/list/list.dart';
import 'package:manga_app/widget/tag/tag.dart';
import 'package:manga_app/widget/text/text.dart';
import 'package:manga_app/widget/image/image_loader.dart';

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
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      height: thumbHeight * 2,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          containerRadius,
        ),
        image: DecorationImage(
          image: MangaImageProvider(
            imageUrl: manga?.thumb,
            referer: manga?.thumb,
          ),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
      child: ListGenerate<Widget>(
        items: [
          _buildCategories(context),
          _buildInfoManga(context),
          const MDivider(fill: true),
          _buildTitleInfo(context),
        ],
        itemBuilder: (widget) => widget,
        crossAxisAlignment: CrossAxisAlignment.stretch,
      ),
    );
  }

  Widget _buildTitleInfo(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            MangaColors.transparent,
            MangaColors.black,
          ],
        ),
      ),
      padding: const EdgeInsets.all(6).copyWith(
        top: 32,
      ),
      child: ListGenerate<Widget>(
        items: [
          MText(
            maxLines: 2,
            text: manga?.name,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
            style: context.titleMedium.white,
          ),
          if (manga?.description?.isEmpty != true)
            MText(
              maxLines: 3,
              text: manga?.description,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: context.bodySmall.white,
            ),
        ],
        spacing: 8,
        itemBuilder: (widget) => widget,
        crossAxisAlignment: CrossAxisAlignment.stretch,
      ),
    );
  }

  Widget _buildInfoManga(BuildContext context) {
    return ListGenerate<Widget>(
      items: [
        MTag(
          radius: containerRadius,
          padding: const EdgeInsets.all(2),
          margin: const EdgeInsets.all(4).copyWith(bottom: 0),
          background: tagColor().withOpacity(0.8),
          icon: Icon(
            Icons.numbers_outlined,
            color: MangaColors.white,
            size: context.bodySuperSmall?.fontSize,
          ),
          content: MText(
            text: manga?.chapters?.firstOrNull()?.name,
            style: context.bodySuperSmall.white,
          ),
        ),
        MTag(
          radius: containerRadius,
          padding: const EdgeInsets.all(2),
          margin: const EdgeInsets.all(4).copyWith(bottom: 0),
          background: tagColor().withOpacity(0.8),
          icon: Icon(
            Icons.timer_outlined,
            color: MangaColors.white,
            size: context.bodySuperSmall?.fontSize,
          ),
          content: MText(
            text: manga?.timeUpdate,
            style: context.bodySuperSmall.white,
          ),
        ),
      ],
      itemBuilder: (widget) => widget,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  Widget _buildCategories(BuildContext context) {
    var categories = manga?.categories ?? [];
    return Container(
      padding: const EdgeInsets.all(6),
      child: Wrap(
        spacing: 4,
        runSpacing: 4,
        children: [
          for (int index = 0; index < maxTagShow(categories); index++)
            if (index == _lengthTagSupport - 1 &&
                categories.length != _lengthTagSupport)
              MTag(
                radius: containerRadius,
                padding: const EdgeInsets.all(2),
                background: tagColor().withOpacity(0.6),
                content: MText(
                  text: "  ...  ",
                  style: context.bodySuperSmall.white,
                ),
              )
            else
              MTag(
                radius: containerRadius,
                padding: const EdgeInsets.all(2),
                background: tagColor().withOpacity(0.6),
                content: MText(
                  text: categories[index],
                  style: context.bodySuperSmall.white,
                ),
              ),
        ],
      ),
    );
  }

  int maxTagShow(List<String> categories) {
    var length = categories.length;
    if (length > (_lengthTagSupport - 1)) {
      return _lengthTagSupport;
    }
    return length - 1;
  }
}
