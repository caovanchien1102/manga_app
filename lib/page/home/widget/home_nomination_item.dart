import 'package:flutter/material.dart';
import 'package:manga_app/widget/divider/divider.dart';
import 'package:manga_app/widget/text/text.dart';
import 'package:manga_app/widget/image/image_loader.dart';

const _maxLineName = 1;

class HomeNominationItem extends StatelessWidget {
  final String url;
  final String imageUrl;
  final String name;
  final String? newChapter;
  final String? timeUpdate;
  final String? referer;

  final double height = 220;
  final double width = 160;

  final void Function(String url) onTap;

  const HomeNominationItem({
    Key? key,
    required this.url,
    required this.imageUrl,
    required this.name,
    required this.onTap,
    this.newChapter,
    this.timeUpdate,
    this.referer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(url),
      child: _frameItem(
        context: context,
        headers: [
          _itemHeader(
            context: context,
            content: newChapter,
            color: Colors.green,
            icon: const Icon(
              Icons.numbers_outlined,
              size: 12,
              color: Colors.white,
            ),
          ),
          _itemHeader(
            context: context,
            content: timeUpdate,
            color: Colors.orange,
            icon: const Icon(
              Icons.timer_outlined,
              size: 12,
              color: Colors.white,
            ),
          )
        ],
        title: name,
      ),
    );
  }

  Widget _frameItem({
    required BuildContext context,
    required List<Widget> headers,
    required String title,
  }) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: MangaImageProvider(
            imageUrl: imageUrl,
            referer: referer,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: headers,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: width,
              padding: const EdgeInsets.only(
                left: 8,
                right: 8,
                top: 16,
                bottom: 6,
              ),
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
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemHeader({
    required BuildContext context,
    required String? content,
    required Color color,
    required Widget icon,
  }) {
    if (content == null) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.only(top: 4, left: 4),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.55),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          icon,
          const MDivider(
            width: 2,
          ),
          Text(
            content,
            style: const TextStyle(
              fontSize: 8,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
