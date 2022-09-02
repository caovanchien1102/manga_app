import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_app/base/base_bloc.dart';
import 'package:manga_app/page/detail/bloc/detail_event.dart';
import 'package:manga_app/page/detail/bloc/detail_state.dart';
import 'package:manga_app/repository/nettruyen_repository.dart';

class DetailBloc extends BaseBloc<DetailEvent, DetailState> {
  DetailBloc() : super(LoadingDetailState()) {
    on<InitDetailEvent>(
      (event, emit) async => await _initDetail(event.path, emit),
    );
  }

  NetTruyenRepo get nettruyenRepo => repo.nettruyenRepo;

  Future<void> _initDetail(String? path, Emitter emit) async {
    await nettruyenRepo.fetchDetailPage(path ?? "").then((value) {
      emit(value);
    });
  }
}
