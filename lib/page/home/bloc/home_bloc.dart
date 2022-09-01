import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_app/base/base_bloc.dart';
import 'package:manga_app/page/home/bloc/home_event.dart';
import 'package:manga_app/page/home/bloc/home_state.dart';
import 'package:manga_app/repository/nettruyen_repository.dart';

typedef HomeBlocType = BaseBloc<HomeEvent, HomeState>;

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc() : super(LoadingHomeState()) {
    on<InitHomeEvent>(
      (event, emit) async => await initHome(emit),
    );
  }

  NetTruyenRepo get nettruyenRepo => repo.nettruyenRepo;

  Future<void> initHome(Emitter emit) async {
    await nettruyenRepo.fetchHomePage().toList().then((states) {
      for (var state in states) {
        emit(state);
      }
    });
  }
}
