import 'package:manga_app/base/state_model.dart';
import 'package:manga_app/page/bloc/base_home_cubit.dart';

class NewUpdateHomeCubit extends BaseHomeCubit {
  init() async {
    var body = await repo.fetchBody(path: "");
    repo.fetchCategories(body).then((value) {
      print("${value.runtimeType}");
      emit(StateModel.success(value));
    });
  }
}
