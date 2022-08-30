import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_app/base/state_model.dart';
import 'package:manga_app/repository/nettruyen_repository.dart';

class BaseHomeCubit extends Cubit<StateModel> {
  NetTruyenRepo repo = NetTruyenRepo();

  BaseHomeCubit() : super(StateModel.loading());
}
