import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_app/base/base_state.dart';
import 'package:manga_app/contant/tag_colors.dart';
import 'package:manga_app/model/chapter.dart';
import 'package:manga_app/model/manga.dart';
import 'package:manga_app/page/content/content_page.dart';
import 'package:manga_app/page/detail/bloc/detail_bloc.dart';
import 'package:manga_app/page/detail/bloc/detail_event.dart';
import 'package:manga_app/page/detail/bloc/detail_state.dart';
import 'package:manga_app/theme/color_scheme.dart';
import 'package:manga_app/theme/size.dart';
import 'package:manga_app/theme/text_style.dart';
import 'package:manga_app/theme/theme_extension.dart';
import 'package:manga_app/utils/list.dart';
import 'package:manga_app/widget/card/card.dart';
import 'package:manga_app/widget/divider/divider.dart';
import 'package:manga_app/widget/image/image_loader.dart';
import 'package:manga_app/widget/tag/tag.dart';
import 'package:manga_app/widget/text/text.dart';
import 'package:manga_app/widget/title/title.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

const _minChapterShow = 10;

class DetailPage extends StatefulWidget {
  static const route = "detail_page";

  final String? path;

  const DetailPage({
    Key? key,
    this.path,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends BaseState<DetailBloc, DetailPage> {
  bool _isReadMoreChapter = false;

  @override
  void initState() {
    bloc.add(
      InitDetailEvent(path: widget.path),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: MText(
          text: "Chi tiết truyện",
          style: context.headerMedium,
        ),
      ),
      body: SafeArea(
        child: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            if (state is SuccessDetailState) {
              var manga = state.manga;
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _detailBuilder(manga),
                    _descriptionBuilder(manga?.description),
                    _chaptersBuilder(manga?.chapters),
                    const MDivider(
                      height: containerMargin,
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _detailBuilder(Manga? manga) {
    return MCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FractionallySizedBox(
            widthFactor: 0.65,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  containerRadius,
                ),
              ),
              child: MangaImage(
                imageUrl: manga?.thumb ?? "",
              ),
            ),
          ),
          const MDivider(height: 16),
          MText(
            text: manga?.name,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: context.headerMedium?.copyWith(
              height: 1.05,
            ),
          ),
          const MDivider(height: 8),
          _itemDetail(
            title: "Tác giả:",
            useTag: false,
            contents: [
              manga?.author ?? "",
            ],
          ),
          _itemDetail(
            title: "Tình trạng:",
            useTag: false,
            contents: [
              manga?.status ?? "",
            ],
          ),
          const MDivider(height: 2),
          _itemDetail(
            title: "Thể loại:",
            contents: manga?.categories ?? [],
          ),
          const MDivider(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: MText(
                    text: "Đọc từ đầu",
                    style: context.bodyMedium,
                  ),
                ),
              ),
              const MDivider(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: MText(
                    text: "Đọc mới nhất",
                    style: context.bodyMedium,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _descriptionBuilder(String? description) {
    if (description == null) {
      return const SizedBox.shrink();
    }

    return MCard(
      header: Padding(
        padding: const EdgeInsets.all(
          containerPadding,
        ).copyWith(bottom: 0),
        child: MTitle(
          title: "Nội dung",
          titleStyle: context.headerSmall,
        ),
      ),
      child: MText(
        text: description,
        style: context.bodyMedium,
      ),
    );
  }

  Widget _chaptersBuilder(List<Chapter>? chapters) {
    ValueNotifier<bool> chaptersNotifier = ValueNotifier(_isReadMoreChapter);

    int length() {
      if (_isReadMoreChapter) {
        return chapters?.length ?? 0;
      } else {
        return (chapters?.length ?? 0) < _minChapterShow
            ? (chapters?.length ?? 0)
            : _minChapterShow;
      }
    }

    if (chapters != null) {
      return MCard(
        header: Padding(
          padding: const EdgeInsets.all(
            containerPadding,
          ).copyWith(bottom: 0),
          child: MTitle(
            title: "Danh sách chương",
            titleStyle: context.headerSmall,
          ),
        ),
        child: ValueListenableBuilder(
          valueListenable: chaptersNotifier,
          builder: (context, value, child) {
            return Column(
              children: [
                for (int index = 0; index < length(); index++) ...[
                  if (index != 0)
                    MDivider(
                      height: 1,
                      top: itemSpace / 2,
                      bottom: itemSpace / 2,
                      color: context.themeData?.dividerColor,
                    ),
                  GestureDetector(
                    onTap: () {
                      print("Tap Tap");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          containerRadius,
                        ),
                      ),
                      padding: const EdgeInsets.all(
                        itemPadding,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          MTitle(
                            title: chapters.getOrNull(index)?.name ?? "",
                            maxLines: 1,
                            titleStyle: context.bodyMedium,
                          ),
                          MTitle(
                            title: chapters.getOrNull(index)?.timeUpdate ?? "",
                            maxLines: 1,
                            titleStyle: context.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  )
                ]
              ],
            );
          },
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _itemDetail({
    required List<String> contents,
    required String? title,
    bool useTag = true,
  }) {
    if (useTag) {
      return Wrap(
        spacing: 4,
        runSpacing: 4,
        children: [
          MText(
            text: title,
            style: context.titleMedium,
          ),
          for (var content in contents)
            MTag(
              background: tagColor(),
              radius: containerRadius,
              padding: const EdgeInsets.symmetric(
                vertical: 2,
                horizontal: 4,
              ),
              content: MText(
                text: content,
                style: context.bodySmall.white,
              ),
            ),
        ],
      );
    } else {
      return Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: "$title ",
              style: context.titleMedium,
            ),
            for (var content in contents)
              TextSpan(
                text: content,
                style: context.bodyMedium,
              )
          ],
        ),
      );
    }
  }
}
