import 'package:flutter/material.dart';
import 'package:manga_app/widget/image/image_loader.dart';

class HomeNewUpdateItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String? referer;

  final double height = 220;
  final double width = 160;

  const HomeNewUpdateItem({
    Key? key,
    required this.imageUrl,
    required this.name,
    this.referer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: height,
        width: width,
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.bottomCenter,
        decoration: _styleMainFrame(),
        child: Container(
          width: width,
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ).copyWith(
            top: 24,
            bottom: 6,
          ),
          decoration: _styleNameFrame(),
          child: _name(),
        ),
      ),
    );
  }

  BoxDecoration _styleNameFrame() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.transparent,
          Colors.black,
        ],
      ),
    );
  }

  BoxDecoration _styleMainFrame() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      image: DecorationImage(
        image: MangaImageProvider(
          imageUrl: imageUrl,
          referer: referer,
        ),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _name() {
    return Text(
      name,
      maxLines: 1,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
    );
  }
}
