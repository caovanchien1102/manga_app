import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_app/base/base_state.dart';
import 'package:manga_app/model/manga.dart';
import 'package:manga_app/page/home/bloc/home_bloc.dart';
import 'package:manga_app/page/home/bloc/home_event.dart';
import 'package:manga_app/page/home/bloc/home_state.dart';
import 'package:manga_app/page/home/widget/home_nomination_item.dart';
import 'package:manga_app/widget/card/card.dart';
import 'package:manga_app/widget/icon/circle.dart';
import 'package:manga_app/widget/title/title.dart';

class HomePage extends StatefulWidget {
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Wrap(
            children: [
              _buildNomination(),
            ],
          ),
        ),
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
        } else {
          mangas.addAll([]);
        }

        return MCard(
          header: const MTitle(
            title: "Truyện đề cử",
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
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(mangas.length, (index) {
                var manga = mangas[index];
                return Padding(
                  padding: EdgeInsets.only(
                    right: index == ((mangas.length) - 1) ? 0 : 16,
                  ),
                  child: HomeNominationItem(
                    url: manga.url ?? "",
                    imageUrl: manga.thumb ?? "",
                    name: manga.name ?? "",
                    newChapter: manga.newChapter,
                    timeUpdate: manga.timeUpdate,
                    onTap: (url) {
                      print("URL: $url");
                    },
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
