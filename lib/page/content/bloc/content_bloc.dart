import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_app/base/base_bloc.dart';
import 'package:manga_app/page/content/bloc/content_event.dart';
import 'package:manga_app/page/content/bloc/content_state.dart';
import 'package:manga_app/repository/nettruyen_repository.dart';

class ContentBloc extends BaseBloc<ContentEvent, ContentState> {
  ContentBloc() : super(LoadingContentState()) {
    on<InitContentEvent>(
      (event, emit) async => await _initContent(event.path, emit),
    );
  }

  NetTruyenRepo get nettruyenRepo => repo.nettruyenRepo;

  Future<void> _initContent(String? path, Emitter emit) async {
    await nettruyenRepo.fetchContentPage(path ?? "").then((value) {
      emit(value);
    });
  }
}
