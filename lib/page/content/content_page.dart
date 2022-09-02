import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_app/base/base_state.dart';
import 'package:manga_app/page/content/bloc/content_bloc.dart';
import 'package:manga_app/page/content/bloc/content_event.dart';
import 'package:manga_app/page/content/bloc/content_state.dart';
import 'package:manga_app/widget/image/image_loader.dart';

class ContentPage extends StatefulWidget {
  static const route = "content_page";

  final String? path;

  const ContentPage({
    Key? key,
    this.path,
  }) : super(key: key);

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends BaseState<ContentBloc, ContentPage> {
  @override
  void initState() {
    bloc.add(InitContentEvent(path: widget.path));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        bloc: bloc,
        builder: (content, state) {
          if (state is SuccessContentState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  for (var imageUrl in state.content?.contents ?? [])
                    MangaImage(
                      imageUrl: imageUrl,
                      referer: state.content?.referer,
                    ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
