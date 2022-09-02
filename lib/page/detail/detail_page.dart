import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_app/base/base_state.dart';
import 'package:manga_app/model/chapter.dart';
import 'package:manga_app/page/content/content_page.dart';
import 'package:manga_app/page/detail/bloc/detail_bloc.dart';
import 'package:manga_app/page/detail/bloc/detail_event.dart';
import 'package:manga_app/page/detail/bloc/detail_state.dart';
import 'package:manga_app/utils/list.dart';
import 'package:manga_app/widget/card/card.dart';
import 'package:manga_app/widget/divider/divider.dart';
import 'package:manga_app/widget/icon/circle.dart';
import 'package:manga_app/widget/image/image_loader.dart';
import 'package:manga_app/widget/text/text.dart';
import 'package:manga_app/widget/title/title.dart';

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
      body: SafeArea(
        child: BlocBuilder(
            bloc: bloc,
            builder: (context, state) {
              if (state is SuccessDetailState) {
                var manga = state.manga;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      MCard(
                        header: const MTitle(
                          title: "Thong tin",
                          icon: CircleTitleIcon(
                            size: 12,
                            color: Colors.blue,
                          ),
                          space: 4,
                          titleStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            FractionallySizedBox(
                              widthFactor: 0.6,
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8)),
                                child: MangaImage(
                                  imageUrl: manga?.thumb ?? "",
                                ),
                              ),
                            ),
                            const MDivider(
                              height: 16,
                            ),
                            MText(
                              text: manga?.name,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            _item(
                              title: "Thể loại:",
                              categories: manga?.categories,
                            ),
                            _item(
                              content: "NỘI DUNG: ${manga?.description}",
                            )
                          ],
                        ),
                      ),
                      _chaptersBuilder(manga?.chapters),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
      ),
    );
  }

  Widget _chaptersBuilder(List<Chapter>? chapters) {
    ValueNotifier<bool> chaptersNotifier = ValueNotifier(_isReadMoreChapter);

    if (chapters != null) {
      return MCard(
        header: const MTitle(
          title: "Chapters",
          icon: CircleTitleIcon(
            size: 12,
            color: Colors.blue,
          ),
          space: 4,
          titleStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        child: ValueListenableBuilder(
          valueListenable: chaptersNotifier,
          builder: (context, value, child) {
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _isReadMoreChapter ? chapters.length : _minChapterShow,
              separatorBuilder: (context, index) {
                return const MDivider(
                  height: 1,
                  top: 8,
                  bottom: 8,
                  color: Colors.grey,
                );
              },
              itemBuilder: (context, index) {
                if (!_isReadMoreChapter && _minChapterShow - 1 == index) {
                  return ElevatedButton(
                    onPressed: () {
                      _isReadMoreChapter = !_isReadMoreChapter;
                      chaptersNotifier.value = _isReadMoreChapter;
                    },
                    child: const Text("Xem them"),
                  );
                }
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).popAndPushNamed(
                      ContentPage.route,
                      arguments: chapters.getOrNull(index)?.url,
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.numbers_outlined,
                            size: 12,
                          ),
                          const MDivider(
                            width: 4,
                          ),
                          MText(
                            text: chapters.getOrNull(index)?.name ?? "",
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.timer_outlined,
                            size: 12,
                          ),
                          const MDivider(
                            width: 4,
                          ),
                          MText(
                            text: chapters.getOrNull(index)?.timeUpdate ?? "",
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _item({
    List<String>? categories,
    String? title,
    String? content,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: categories != null ? 4 : 0,
          ),
          child: MText(
            text: title,
          ),
        ),
        Expanded(
          child: categories != null
              ? Wrap(
                  children: [
                    for (var category in categories)
                      _itemHeader(
                        context: context,
                        content: category,
                        color: Colors.blue,
                      ),
                  ],
                )
              : MText(
                  text: content,
                ),
        ),
      ],
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
}
