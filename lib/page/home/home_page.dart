import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_app/base/base_state.dart';
import 'package:manga_app/model/manga.dart';
import 'package:manga_app/page/detail/detail_page.dart';
import 'package:manga_app/page/home/bloc/home_bloc.dart';
import 'package:manga_app/page/home/bloc/home_event.dart';
import 'package:manga_app/page/home/bloc/home_state.dart';
import 'package:manga_app/page/home/widget/home_new_update_item.dart';
import 'package:manga_app/page/home/widget/home_nomination_item.dart';
import 'package:manga_app/theme/size.dart';
import 'package:manga_app/theme/text_style.dart';
import 'package:manga_app/widget/card/card.dart';
import 'package:manga_app/widget/divider/divider.dart';
import 'package:manga_app/widget/list/list.dart';
import 'package:manga_app/widget/text/text.dart';
import 'package:manga_app/widget/title/title.dart';

class HomePage extends StatefulWidget {
  static const route = "home_page";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomeBloc, HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      bloc.add(InitHomeEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const MText(
          text: "Trang chủ",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      drawer: Drawer(
        child: _buildDrawerMenu(context),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MDivider(
              height: 8,
            ),
            _buildNomination(),
            _buildNewUpdate(),
            const MDivider(
              height: containerMargin,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerMenu(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          MText(
            text: 'NetTruyen',
          )
        ],
      ),
    );
  }

  Widget _buildNomination() {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: bloc,
      buildWhen: (oldState, newState) {
        return newState is NominationHomeState;
      },
      builder: (context, state) {
        var mangas = <Manga>[];

        if (state is NominationHomeState) {
          mangas.addAll(state.mangas ?? []);
        }

        return MCard(
          header: Padding(
            padding: const EdgeInsets.all(
              containerPadding,
            ).copyWith(bottom: 0),
            child: MTitle(
              title: "Truyện đề cử",
              titleStyle: context.headerSmall,
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ListGenerate<Manga>(
              items: mangas,
              spacing: 8,
              direction: Axis.horizontal,
              itemBuilder: (manga) {
                return HomeNominationItem(
                  manga: manga,
                  onTap: (url) {
                    goToDetailPage(url);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildNewUpdate() {
    return BlocBuilder(
      bloc: bloc,
      buildWhen: (oldState, newState) {
        return newState is NewMangaUpdateHomeState;
      },
      builder: (context, state) {
        var mangas = <Manga>[];

        if (state is NewMangaUpdateHomeState) {
          mangas.addAll(state.mangas ?? []);
        }

        return MCard(
          header: Padding(
            padding: const EdgeInsets.all(
              containerPadding,
            ).copyWith(bottom: 0),
            child: MTitle(
              title: "Truyện mới cập nhật",
              titleStyle: context.headerSmall,
            ),
          ),
          child: ListGenerate<Manga?>(
            items: mangas,
            spacing: 16,
            itemBuilder: (manga) {
              return HomeNewUpdateItem(
                manga: manga,
                onTap: (url) {
                  Navigator.of(context).pushNamed(
                    DetailPage.route,
                    arguments: url,
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  /// === === ///

  void goToDetailPage(String? path) {
    Navigator.of(context).pushNamed(
      DetailPage.route,
      arguments: path,
    );
  }
}
