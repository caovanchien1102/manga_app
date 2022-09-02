import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MangaImage extends StatelessWidget {
  final String imageUrl;
  final String? referer;
  final Widget Function()? errorBuilder;

  const MangaImage({
    Key? key,
    required this.imageUrl,
    this.referer,
    this.errorBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (_, __) => placeholder(),
      errorWidget: (_, __, ___) => error(),
      httpHeaders: {
        "Referer": referer ?? "",
      },
    );
  }

  Widget placeholder() {
    return const SizedBox(
      child: Center(
        child: SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget error() {
    return errorBuilder?.call() ??
        Container(
          color: Colors.red,
        );
  }
}

class MangaImageProvider extends CachedNetworkImageProvider {
  MangaImageProvider({
    required String imageUrl,
    String? referer,
  }) : super(
          imageUrl,
          headers: {
            "Referer": referer ?? "",
          },
        );
}
